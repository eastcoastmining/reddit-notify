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
