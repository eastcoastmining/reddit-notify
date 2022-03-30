module Web.Routes where

import Generated.Types
import IHP.RouterPrelude
import Web.Types

instance HasPath StaticController where
    pathTo WelcomeAction = "/"

instance CanRoute StaticController where
    parseRoute' = do
        string "/"
        endOfInput
        pure WelcomeAction

instance AutoRoute SessionsController
instance AutoRoute UsersController
-- Generator Marker
