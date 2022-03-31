module Application.Reddit
( doesSubredditExist
, subredditNewListingsJsonUrl
) where

import Control.Exception
import Control.Lens
import qualified Data.Aeson as Json
import qualified Data.Aeson.TH as Json
import Data.List
import IHP.Prelude
import Network.HTTP.Client (HttpException)
import Network.Wreq

data AboutSubreddit
    = AboutSubreddit { kind :: Text }
    deriving (Eq, Show, Data)
Json.deriveJSON Json.defaultOptions ''AboutSubreddit

doesSubredditExist :: Text -> IO Bool
doesSubredditExist subredditUrl = do
    let urlNormalized = dropWhileEnd (== '/') (cs subredditUrl)
    let jsonUrl = urlNormalized <> "/about.json"
    maybeResponse <- try $ Network.Wreq.get jsonUrl
    case maybeResponse of
        Left (e :: HttpException) -> pure False
        Right response -> do
            aboutSubreddit :: AboutSubreddit <- either fail return $ Json.eitherDecode (response ^. responseBody)
            let kind = IHP.Prelude.get #kind aboutSubreddit
            pure $ kind == "t5" -- t5 meaning Subreddit

subredditNewListingsJsonUrl :: Text -> Text
subredditNewListingsJsonUrl subredditUrl =
    let
        urlNormalized = dropWhileEnd (== '/') (cs subredditUrl)
        jsonUrl = urlNormalized <> "/new.json"
    in
        cs jsonUrl
