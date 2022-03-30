module Web.Controller.Users where

import Web.Controller.Prelude
import Web.Types
import Web.View.Users.New

instance Controller UsersController where
    action NewUserAction = do
        let user = newRecord @User
        render NewView { .. }

    action CreateUserAction = do
        let user = newRecord @User
        user
            |> fill @["email", "passwordHash"]
            |> validateField #email isEmail
            |> validateField #passwordHash nonEmpty
            |> validateIsUnique #email
            >>= ifValid \case
                Left user -> do
                    render NewView { .. }
                Right user -> do
                    hashed <- hashPassword (get #passwordHash user)
                    user <- user
                        |> set #passwordHash hashed
                        |> createRecord
                    login user
                    setSuccessMessage "You have registered successfully"
                    redirectToPath "/"
