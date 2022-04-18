module Application.Reddit where

import Control.Exception
import Control.Lens hiding ((|>))
import qualified Data.Aeson as Json hiding (Object)
import Data.Aeson.Lens (key, nth)
import qualified Data.Aeson.Schema as Json
import qualified Data.Aeson.TH as Json
import Data.List
import Data.Time.Clock.POSIX
import IHP.Prelude
import Network.HTTP.Client (HttpException)
import Network.Wreq

data AboutSubreddit
    = AboutSubreddit { kind :: Text }
    deriving (Eq, Show, Data)
Json.deriveJSON Json.defaultOptions ''AboutSubreddit

data SubredditListing
    = SubredditListing { title :: Text, permalink :: Text, createdAt :: UTCTime, subredditName :: Text }
    deriving (Eq, Show, Data)
Json.deriveJSON Json.defaultOptions ''SubredditListing

subredditFetchListings :: Text -> IO [SubredditListing]
subredditFetchListings subredditJsonEndpoint = do
    maybeResponse <- try $ Network.Wreq.get (cs subredditJsonEndpoint)
    case maybeResponse of
        Left (e :: HttpException) -> throw e
        Right response -> do
            object <- either fail return $ Json.eitherDecode (response ^. responseBody)
            let deserialized = (object :: Json.Object [Json.schema|{
                data: {
                    children: List {
                        data: {
                            title: Text,
                            permalink: Text,
                            created_utc: NominalDiffTime,
                            subreddit_name_prefixed: Text
                        }
                    }
                }
            }|])
            let listings =
                    [Json.get| deserialized.data.children[].data |]
                        |> map (\listing ->
                                    let
                                        title = [Json.get| listing.title |]
                                        permalink = [Json.get| listing.permalink |]
                                        createdAt = [Json.get| listing.created_utc |] |> posixSecondsToUTCTime
                                        subredditName = [Json.get| listing.subreddit_name_prefixed |]
                                    in
                                        SubredditListing { title, permalink, createdAt, subredditName }
                                )
            pure listings

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
