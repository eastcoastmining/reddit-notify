module Web.View.Dashboard where

import Web.View.Prelude

data DashboardView = DashboardView { posts :: [SubredditPost], todaysDate :: UTCTime }

instance View DashboardView where
    html DashboardView { .. } = [hsx|
        {navigation}
        {renderPosts posts}
    |]
        where
            renderPosts :: [SubredditPost] -> Html
            renderPosts []    = [hsx|
                <ul class="list-group">
                    <li class="list-group-item">
                        No new posts
                    </li>
                </ul>
            |]
            renderPosts posts = [hsx|
                <ul class="list-group">
                    {forEach posts renderPost}
                </ul>
            |]

            renderPost :: SubredditPost -> Html
            renderPost post = [hsx|
                <li class={classes [("list-group-item", True), postColorizer]}>
                    <p>{get #subredditName post}{" - " :: Text}<small> {dateTime $ get #createdAt post}</small></p>
                    <a class={classes [("post-visited", postVisited)]} target="_blank" href={VisitPost (get #id post)}>{get #title post}</a>
                </li>
            |]
                where
                    postVisited = get #visitedPost post
                    isCreatedToday = isPostCreatedToday todaysDate post
                    postColorizer =
                        if isCreatedToday
                        then "border-success border-right-0 border-top-0 border-bottom-0"
                        else "border-warning border-right-0 border-top-0 border-bottom-0"

navigation :: Html
navigation = [hsx|
    <nav class="navbar navbar-light bg-light">
        <a class="navbar-brand" href={DashboardAction currentUserId}>Reddit Notify</a>
        <div>
            <a class="btn btn-outline-dark" href={SubredditsAction currentUserId}>Manage Subreddits</a>
            <a class="js-delete js-delete-no-confirm btn btn-outline-danger ml-2" href={DeleteSessionAction}>Logout</a>
        </div>
    </nav>
|]

isPostCreatedToday :: UTCTime -> SubredditPost -> Bool
isPostCreatedToday todaysDate post =
    let
        createdAt = get #createdAt post
        diff = diffUTCTime todaysDate createdAt
    in
        diff <= nominalDay
