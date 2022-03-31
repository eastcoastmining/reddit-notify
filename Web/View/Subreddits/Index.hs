module Web.View.Subreddits.Index where

import Web.View.Prelude

data IndexView = IndexView { subreddits :: [Subreddit]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Subreddit</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>{forEach subreddits renderSubreddit}</tbody>
            </table>

        </div>
    |]
        where
            breadcrumb = renderBreadcrumb
                [ breadcrumbLink "Dashboard" (DashboardAction currentUserId)
                , breadcrumbText "Manage Subreddits"
                , breadcrumbLink "Watch New Subreddit" (NewSubredditAction currentUserId)
                ]

renderSubreddit :: Subreddit -> Html
renderSubreddit subreddit = [hsx|
    <tr>
        <td><a href={get #url subreddit} target="_blank">{get #url subreddit}</a></td>
        <td><a href={DeleteSubredditAction (get #id subreddit)} class="js-delete text-muted">Delete</a></td>
    </tr>
|]
