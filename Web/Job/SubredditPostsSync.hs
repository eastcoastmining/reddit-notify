module Web.Job.SubredditPostsSync where

import qualified Application.Reddit as Reddit
import Web.Controller.Prelude

instance Job SubredditPostsSyncJob where
    perform SubredditPostsSyncJob { .. } = do
        subreddit <- fetch subredditId
        let jsonUrl = subreddit |> get #jsonUrl
        listings <- Reddit.subredditFetchListings jsonUrl
        posts <- mapM (\listing ->
                        newRecord @SubredditPost
                            |> set #title (get #title listing)
                            |> set #url (get #url listing)
                            |> set #createdAt (get #createdAt listing)
                            |> set #subredditId (get #id subreddit)
                            |> validateIsUnique #url
                            >>= ifValid \case
                                Left post  -> pure post
                                Right post -> createRecord post
                    ) listings

        -- Schedule Another Job To Run In Two Minutes
        now <- getCurrentTime
        let inTwoMinutes = now |> addUTCTime (secondsToNominalDiffTime (60 * 2))
        newJob <-
            newRecord @SubredditPostsSyncJob
                |> set #subredditId (get #id subreddit)
                |> set #runAt inTwoMinutes
                |> createRecord
        pure ()
