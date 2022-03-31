module Web.View.Dashboard where

import Web.View.Prelude

data DashboardView = DashboardView

instance View DashboardView where
    html DashboardView = [hsx|
        {navigation}
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
