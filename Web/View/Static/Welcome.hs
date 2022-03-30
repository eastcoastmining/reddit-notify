module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
         <div class="jumbotron">
              <div style="max-width: 800px; margin-left: auto; margin-right: auto">
                  <h1 class="display-4">
                      Reddit Notify
                  </h1>

                  <p class="lead">
                     Notify When There Is A New Submission On Your Specified Subreddit(s)
                  </p>

                  <hr class="my-4">

                  <a href="" class="btn btn-outline-dark">Login</a>
                  <a href="" class="btn btn-outline-dark ml-2">Register</a>
              </div>
         </div>
|]
