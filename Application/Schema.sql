CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE subreddits (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    json_url TEXT NOT NULL,
    url TEXT NOT NULL UNIQUE,
    user_id UUID NOT NULL
);
CREATE INDEX subreddits_index ON subreddits (user_id);
ALTER TABLE subreddits ADD CONSTRAINT subreddits_ref_user_id FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE;
