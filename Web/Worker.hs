module Web.Worker where

import Generated.Types
import IHP.Job.Runner
import IHP.Job.Types
import IHP.Prelude
import Web.Types

import Web.Job.SubredditPostsDelete
import Web.Job.SubredditPostsSync

instance Worker WebApplication where
    workers _ =
        [ worker @SubredditPostsSyncJob
        -- Generator Marker
        , worker @SubredditPostsDeleteJob
        ]
