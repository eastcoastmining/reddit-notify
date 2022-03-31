module Web.Controller.Dashboard where

import Web.Controller.Prelude
import Web.View.Dashboard

instance Controller DashboardController where
    beforeAction = do
        ensureIsUser

    action DashboardAction { .. } = do
        render DashboardView
