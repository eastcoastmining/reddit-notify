CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL,
    days_after_posts_deleted INT DEFAULT 5 NOT NULL
);
CREATE TABLE subreddits (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    json_url TEXT NOT NULL,
    url TEXT NOT NULL UNIQUE,
    user_id UUID NOT NULL
);
CREATE INDEX subreddits_index ON subreddits (user_id);
CREATE TABLE subreddit_posts_sync_jobs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    status JOB_STATUS DEFAULT 'job_status_not_started' NOT NULL,
    last_error TEXT DEFAULT NULL,
    attempts_count INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    locked_by UUID DEFAULT NULL,
    run_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    subreddit_id UUID NOT NULL
);
CREATE INDEX subreddit_posts_sync_jobs_subreddit_id_index ON subreddit_posts_sync_jobs (subreddit_id);
CREATE TABLE subreddit_posts (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    subreddit_id UUID NOT NULL,
    title TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL,
    subreddit_name TEXT NOT NULL,
    permalink TEXT NOT NULL UNIQUE,
    visited_post BOOLEAN DEFAULT false NOT NULL
);
CREATE INDEX subreddit_posts_subreddit_id_index ON subreddit_posts (subreddit_id);
CREATE TABLE subreddit_posts_delete_jobs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    status JOB_STATUS DEFAULT 'job_status_not_started' NOT NULL,
    last_error TEXT DEFAULT NULL,
    attempts_count INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    locked_by UUID DEFAULT NULL,
    run_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
ALTER TABLE subreddit_posts ADD CONSTRAINT subreddit_posts_ref_subreddit_id FOREIGN KEY (subreddit_id) REFERENCES subreddits (id) ON DELETE CASCADE;
ALTER TABLE subreddit_posts_sync_jobs ADD CONSTRAINT subreddit_posts_sync_jobs_ref_subreddit_id FOREIGN KEY (subreddit_id) REFERENCES subreddits (id) ON DELETE CASCADE;
ALTER TABLE subreddits ADD CONSTRAINT subreddits_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
