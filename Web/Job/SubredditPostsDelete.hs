module Web.Job.SubredditPostsDelete where

import Web.Controller.Prelude

instance Job SubredditPostsDeleteJob where
    perform SubredditPostsDeleteJob { .. } = do
        subredditPosts :: [SubredditPost] <-
            sqlQuery "SELECT subreddit_posts.* FROM subreddit_posts INNER JOIN subreddits ON subreddit_posts.subreddit_id = subreddits.id INNER JOIN users ON subreddits.user_id = users.id WHERE subreddit_posts.created_at <= (NOW() - make_interval(days := users.days_after_posts_deleted))" ()
        deleteRecords subredditPosts
        pure ()
