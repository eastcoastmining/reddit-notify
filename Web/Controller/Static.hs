module Web.Controller.Static where

import Web.Controller.Prelude
import Web.View.Static.Welcome

instance Controller StaticController where
    beforeAction = do
        when (isJust currentUserOrNothing) do
            redirectTo (DashboardAction currentUserId)

    action WelcomeAction = do
        render WelcomeView
