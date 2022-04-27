module Web.Types where

import Generated.Types
import IHP.LoginSupport.Types
import IHP.ModelSupport
import IHP.Prelude

data WebApplication
    = WebApplication
    deriving (Eq, Show)

data StaticController
    = WelcomeAction
    deriving (Eq, Show, Data)

data SessionsController
    = NewSessionAction
    | CreateSessionAction
    | DeleteSessionAction
    deriving (Eq, Show, Data)

instance HasNewSessionUrl User where
    newSessionUrl _ = "/NewSession"
type instance CurrentUserRecord = User

data UsersController
    = NewUserAction
    | CreateUserAction
    | UpdateUserConfigAction
    deriving (Eq, Show, Data)

data DashboardController
    = DashboardAction { userId :: !(Id User) }
    | VisitPost { subredditPostId :: !(Id SubredditPost) }
    deriving (Eq, Show, Data)

data SubredditsController
    = SubredditsAction { userId :: !(Id User) }
    | NewSubredditAction { userId :: !(Id User) }
    | CreateSubredditAction
    | DeleteSubredditAction { subredditId :: !(Id Subreddit) }
    | SyncSubredditAction { subredditId :: !(Id Subreddit) }
    deriving (Eq, Show, Data)
