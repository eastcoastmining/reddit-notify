module Application.Helper.View where

import Generated.Types
import IHP.ViewPrelude
import Web.Types

-- Here you can add functions which are available in all your views

currentUserId :: _ => Id User
currentUserId = currentUser |> get #id
