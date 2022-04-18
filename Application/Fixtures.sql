

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.users DISABLE TRIGGER ALL;

INSERT INTO public.users (id, email, password_hash, locked_at, failed_login_attempts) VALUES ('bbd1a1f9-2dfb-4ada-b7e6-f7afcc7b9693', 'test@example.com', 'sha256|17|5JDYwvpZpMMuGf9rL41h0Q==|eJfBx7pSD4slMkziQq0XJwh491R/H/FYhG20W3MWx3Q=', NULL, 0);


ALTER TABLE public.users ENABLE TRIGGER ALL;


ALTER TABLE public.subreddits DISABLE TRIGGER ALL;



ALTER TABLE public.subreddits ENABLE TRIGGER ALL;


ALTER TABLE public.subreddit_posts DISABLE TRIGGER ALL;



ALTER TABLE public.subreddit_posts ENABLE TRIGGER ALL;


ALTER TABLE public.subreddit_posts_sync_jobs DISABLE TRIGGER ALL;



ALTER TABLE public.subreddit_posts_sync_jobs ENABLE TRIGGER ALL;


