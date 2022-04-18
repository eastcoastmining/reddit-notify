module Web.Controller.Subreddits where

import qualified Application.Reddit as Reddit
import qualified Network.URI as URI
import Web.Controller.Prelude
import Web.View.Subreddits.Index
import Web.View.Subreddits.New

instance Controller SubredditsController where
    beforeAction = do
        ensureIsUser

    action SubredditsAction { .. } = do
        subreddits <- query @Subreddit
            |> filterWhere (#userId, currentUserId)
            |> fetch
        render IndexView { .. }

    action NewSubredditAction { .. } = do
        let subreddit = newRecord |> set #userId currentUserId
        render NewView { .. }

    action CreateSubredditAction = do
        let subreddit = newRecord @Subreddit
        subreddit
            |> buildSubreddit
            |> set #userId currentUserId
            |> validateIsUnique #url
            >>= validateFieldIO #url validateSubredditExists
            >>= ifValid \case
                Left subreddit -> render NewView { .. }
                Right subreddit -> do
                    let jsonUrl = Reddit.subredditNewListingsJsonUrl (get #url subreddit)
                    subreddit <- subreddit
                        |> set #jsonUrl jsonUrl
                        |> createRecord
                    subredditSyncJob <- newSubredditSyncJob subreddit
                    setSuccessMessage "Subreddit added"
                    redirectTo $ SubredditsAction currentUserId

    action DeleteSubredditAction { subredditId } = do
        subreddit <- fetch subredditId
        deleteJobs <- deleteAllSubredditSyncJobs subreddit
        deleteRecord subreddit
        setSuccessMessage "Subreddit deleted"
        redirectTo $ SubredditsAction currentUserId

buildSubreddit subreddit = subreddit
    |> fill @'["url"]

validateSubredditExists :: Text -> IO ValidatorResult
validateSubredditExists subredditUrl = do
    if not $ URI.isURI $ cs subredditUrl
    then do
        pure $ Failure "This is not a valid URL"
    else do
        subredditExists <- Reddit.doesSubredditExist subredditUrl
        if subredditExists
        then pure Success
        else pure $ Failure "This subreddit does not exist"

newSubredditSyncJob :: _ => Subreddit -> IO ()
newSubredditSyncJob subreddit = do
    newJob <-
        newRecord @SubredditPostsSyncJob
            |> set #subredditId (get #id subreddit)
            |> createRecord
    pure ()

deleteAllSubredditSyncJobs :: _ => Subreddit -> IO ()
deleteAllSubredditSyncJobs subreddit = do
    jobs <- query @SubredditPostsSyncJob
        |> filterWhere (#subredditId, get #id subreddit)
        |> fetch
    _ <- deleteRecords jobs
    pure ()
