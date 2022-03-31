module Web.FrontController where

import IHP.LoginSupport.Middleware
import IHP.RouterPrelude
import Web.Controller.Prelude
import Web.View.Layout (defaultLayout)

import Web.Controller.Dashboard
import Web.Controller.Sessions
import Web.Controller.Static
import Web.Controller.Subreddits
import Web.Controller.Users
-- Controller Imports

instance FrontController WebApplication where
    controllers =
        [ startPage WelcomeAction
        , parseRoute @SessionsController
        , parseRoute @UsersController
        , parseRoute @DashboardController
        , parseRoute @SubredditsController
        -- Generator Marker
        ]

instance InitControllerContext WebApplication where
    initContext = do
        setLayout defaultLayout
        initAutoRefresh
        initAuthentication @User
