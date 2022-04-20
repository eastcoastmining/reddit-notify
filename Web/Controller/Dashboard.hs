module Web.Controller.Dashboard where

import Web.Controller.Prelude
import Web.View.Dashboard

instance Controller DashboardController where
    beforeAction = do
        ensureIsUser

    action DashboardAction { .. } = autoRefresh do
        subreddits <-
            query @Subreddit
                |> filterWhere (#userId, userId)
                |> fetch

        posts <-
            query @SubredditPost
                |> filterWhereIn (#subredditId, ids subreddits)
                |> orderByDesc #createdAt
                |> fetch

        todaysDate <- getCurrentTime

        render DashboardView { .. }

    action VisitPost { subredditPostId } = do
        subredditPost <- fetch subredditPostId
        subredditPost <-
            subredditPost
                |> set #visitedPost True
                |> updateRecord
        let postUrl = fullPostUrl (get #permalink subredditPost)
        redirectToUrl postUrl


fullPostUrl :: Text -> Text
fullPostUrl permalink = "https://www.reddit.com" <> permalink
