module Web.View.Subreddits.New where

import Web.View.Prelude

data NewView = NewView { subreddit :: Subreddit }

instance View NewView where
    html NewView { .. } = [hsx|
        {breadcrumb}

        <h2>Watch New Subreddit</h2>

        {renderForm subreddit}
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Dashboard" (DashboardAction currentUserId)
                , breadcrumbLink "Manage Subreddits" (SubredditsAction currentUserId)
                , breadcrumbText "Watch New Subreddit"
                ]

renderForm :: Subreddit -> Html
renderForm subreddit = formFor subreddit [hsx|
    {(textField #url) { fieldLabel = "Link To Subreddit", placeholder  = "https://www.reddit.com/r/AskReddit/" }}

    {(submitButton) { label ="Watch Subreddit" }}
|]
