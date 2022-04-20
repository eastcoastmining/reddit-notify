module Web.View.Layout (defaultLayout, Html) where

import Application.Helper.View
import Generated.Types
import IHP.Controller.RequestContext
import IHP.Environment
import IHP.ViewPrelude
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A
import Web.Routes
import Web.Types

defaultLayout :: Html -> Html
defaultLayout inner = H.docTypeHtml ! A.lang "en" $ [hsx|
<head>
    {metaTags}

    {stylesheets}
    {scripts}

    <title>{pageTitleOrDefault "Reddit Notify"}</title>
</head>
<body>
    <div class="container mt-4">
        {renderFlashMessages}
        {inner}
    </div>
</body>
|]

-- The 'assetPath' function used below appends a `?v=SOME_VERSION` to the static assets in production
-- This is useful to avoid users having old CSS and JS files in their browser cache once a new version is deployed
-- See https://ihp.digitallyinduced.com/Guide/assets.html for more details

stylesheets :: Html
stylesheets = [hsx|
        <link rel="stylesheet" href={assetPath "/vendor/bootstrap.min.css"}/>
        <!-- <link rel="stylesheet" href={assetPath "/vendor/flatpickr.min.css"}/> -->
        <link rel="stylesheet" href={assetPath "/app.css"}/>
    |]

scripts :: Html
scripts = [hsx|
        {when isDevelopment devScripts}
        <!-- <script defer src={assetPath "/vendor/jquery-3.6.0.slim.min.js"}></script> -->
        <!-- <script defer src={assetPath "/vendor/timeago.js"}></script> -->
        <!-- <script defer src={assetPath "/vendor/popper.min.js"}></script> -->
        <!-- <script defer src={assetPath "/vendor/bootstrap.min.js"}></script> -->
        <!-- <script defer src={assetPath "/vendor/flatpickr.js"}></script> -->
        <script defer src={assetPath "/vendor/morphdom-umd.min.js"}></script>
        <script defer src={assetPath "/vendor/turbolinks.js"}></script>
        <script defer src={assetPath "/vendor/turbolinksInstantClick.js"}></script>
        <script defer src={assetPath "/vendor/turbolinksMorphdom.js"}></script>
        <script defer src={assetPath "/helpers.js"}></script>
        <script defer src={assetPath "/ihp-auto-refresh.js"}></script>
        <!-- <script defer src={assetPath "/app.js"}></script> -->
    |]

devScripts :: Html
devScripts = [hsx|
        <script id="livereload-script" src={assetPath "/livereload.js"} data-ws={liveReloadWebsocketUrl}></script>
    |]

metaTags :: Html
metaTags = [hsx|
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>

    <meta property="og:title" content="Reddit Notify"/>
    <meta property="og:type" content="website"/>
    <meta property="og:url" content="https://redditnotify.ihpapp.com"/>
    <meta property="og:description" content="Reddit Subreddits New Submission Notifications"/>

    {autoRefreshMeta}
|]
