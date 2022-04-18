module Web.View.Dashboard where

import Web.View.Prelude

data DashboardView = DashboardView { posts :: [SubredditPost] }

instance View DashboardView where
    html DashboardView { .. } = [hsx|
        {navigation}
        {renderPosts posts}
    |]

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
    <li class="list-group-item">
        <p>{get #subredditName post}{" - " :: Text}<small> {dateTime $ get #createdAt post}</small></p>
        <a target="_blank" href={fullPostUrl $ get #permalink post}>{get #title post}</a>
    </li>
|]

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

fullPostUrl :: Text -> Text
fullPostUrl permalink = "https://www.reddit.com" <> permalink
