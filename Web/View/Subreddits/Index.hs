module Web.View.Subreddits.Index where

import Web.View.Prelude

data IndexView = IndexView { subreddits :: [Subreddit]  }

instance View IndexView where
    html IndexView { .. } = [hsx|
        {breadcrumb}

        {updateConfigForm}

        <div class="table-responsive">
            <table class="table">
                <thead>
                    <tr>
                        <th>Subreddit</th>
                        <th></th>
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
        <td>{triggerSyncForm subreddit}</td>
        <td>
            <button class="btn btn-secondary">
                <a href={DeleteSubredditAction (get #id subreddit)} class="js-delete text-white">Delete</a>
            </button>
        </td>
    </tr>
|]

updateConfigForm :: Html
updateConfigForm = [hsx|
<form class="form-inline" method="POST" action={UpdateUserConfigAction}>
    <input type="hidden" id="user_id" name="user_id" value={inputValue (get #id currentUser)}>

    <label for="daysAfterPostsDeleted" class="m-2">Days After Old Posts Deleted</label>
    <input type="number" class="form-control m-2 mr-sm-2" id="daysAfterPostsDeleted" name="daysAfterPostsDeleted" value={inputValue daysAfterPostsDeleted}>

    <button type="submit" class="btn btn-primary m-2">Update</button>
</form>
|]
    where
        daysAfterPostsDeleted = currentUser |> get #daysAfterPostsDeleted

triggerSyncForm :: Subreddit -> Html
triggerSyncForm subreddit = [hsx|
<form class="d-inline" method="POST" action={SyncSubredditAction (get #id subreddit)}>
    <button type="submit" class="btn btn-secondary">Trigger Sync</button>
</form>
|]
