

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

INSERT INTO public.subreddits (id, json_url, url, user_id) VALUES ('f88d9749-8bd2-4918-aa97-98c72dbf9337', 'https://www.reddit.com/r/IHPFramework/new.json', 'https://www.reddit.com/r/IHPFramework/', 'bbd1a1f9-2dfb-4ada-b7e6-f7afcc7b9693');


ALTER TABLE public.subreddits ENABLE TRIGGER ALL;


ALTER TABLE public.subreddit_posts DISABLE TRIGGER ALL;

INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('5d065d8b-b753-4d2d-aa84-c6101f51e2ec', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Lazy loading for table results support request', '2021-08-28 12:27:57-04', 'r/IHPFramework', '/r/IHPFramework/comments/pdcxzr/lazy_loading_for_table_results_support_request/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('a324ce43-3ac5-40ca-a84b-2899916409f6', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'IHP is now affiliated with the Haskell Foundation', '2021-05-28 13:00:12-04', 'r/IHPFramework', '/r/IHPFramework/comments/nn2ba8/ihp_is_now_affiliated_with_the_haskell_foundation/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('6b88ffe6-daa0-4ef4-adec-eb93e0557a89', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Awesome IHP: Awesome list of IHP links &amp; projects', '2021-04-13 01:50:44-04', 'r/IHPFramework', '/r/IHPFramework/comments/mpw6fh/awesome_ihp_awesome_list_of_ihp_links_projects/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('f92b84c2-663e-481e-a8d9-7b4b0f5e806d', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'IHP Global Meetup', '2021-03-05 06:39:15-05', 'r/IHPFramework', '/r/IHPFramework/comments/lya0ej/ihp_global_meetup/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('37cc9b65-0ee4-49d1-96c3-b10a1ff624f4', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'IHP v0.9 has been released 🎉', '2021-02-26 12:23:03-05', 'r/IHPFramework', '/r/IHPFramework/comments/lt2rzi/ihp_v09_has_been_released/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('b673ebb7-c950-4f9d-9925-a879fa08dbf4', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Having trouble making haskell-language-server and emacs work with IHP', '2021-01-10 06:00:44-05', 'r/IHPFramework', '/r/IHPFramework/comments/kucjnu/having_trouble_making_haskelllanguageserver_and/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('0707a799-d668-4da4-a64f-fde4d7d8f6c8', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Will IHP have Live View in the future?', '2020-12-18 07:15:42-05', 'r/IHPFramework', '/r/IHPFramework/comments/kfk1ln/will_ihp_have_live_view_in_the_future/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('326e93dc-3b69-49eb-8ba1-752a880651d6', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'IHP Casts 1.9: Changing the Homepage', '2020-12-07 11:14:05-05', 'r/IHPFramework', '/r/IHPFramework/comments/k8jiqp/ihp_casts_19_changing_the_homepage/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('2b4e47b3-6a41-43cc-9ae2-8da5a09b533b', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Front End design for Charts, graphs, tables', '2020-11-29 05:57:57-05', 'r/IHPFramework', '/r/IHPFramework/comments/k37l8m/front_end_design_for_charts_graphs_tables/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('d8b55c0a-3026-4249-9df3-ad5431865809', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'We now have a IHP Slack Community', '2020-11-03 09:30:14-05', 'r/IHPFramework', '/r/IHPFramework/comments/jnb7uy/we_now_have_a_ihp_slack_community/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('b4623002-90c6-432f-abc6-c9c0406f0da1', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Haskell: The Good Parts', '2020-10-29 11:47:48-04', 'r/IHPFramework', '/r/IHPFramework/comments/jkchnv/haskell_the_good_parts/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('7f15a1be-76a1-443a-acd3-35aec367574f', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'New IHP Release: Beta 18.09.2020', '2020-09-18 12:59:26-04', 'r/IHPFramework', '/r/IHPFramework/comments/iv9y15/new_ihp_release_beta_18092020/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('1ede378b-f9f3-480b-b423-d841c064a20d', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Benchmark: IHP vs. Rails vs. Phoenix vs. Warp', '2020-09-14 11:42:48-04', 'r/IHPFramework', '/r/IHPFramework/comments/isncke/benchmark_ihp_vs_rails_vs_phoenix_vs_warp/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('ab3af013-7de7-4c77-9489-0e29a59e3c9c', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'IHP Casts 1.1: Getting Started with Haskell and IHP', '2020-09-08 13:23:48-04', 'r/IHPFramework', '/r/IHPFramework/comments/ioxunx/ihp_casts_11_getting_started_with_haskell_and_ihp/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('54973e4c-5331-46a1-aa13-d9ceeb2e8ce2', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Good First Issue: Improve Session Functions', '2020-09-06 07:06:52-04', 'r/IHPFramework', '/r/IHPFramework/comments/ink956/good_first_issue_improve_session_functions/', false);
INSERT INTO public.subreddit_posts (id, subreddit_id, title, created_at, subreddit_name, permalink, visited_post) VALUES ('e6e5b6e9-1075-408d-a1ae-0c70e010e992', 'f88d9749-8bd2-4918-aa97-98c72dbf9337', 'Welcome to the IHP Haskell Framework Subreddit!', '2020-08-26 07:14:35-04', 'r/IHPFramework', '/r/IHPFramework/comments/igwy60/welcome_to_the_ihp_haskell_framework_subreddit/', false);


ALTER TABLE public.subreddit_posts ENABLE TRIGGER ALL;


ALTER TABLE public.subreddit_posts_sync_jobs DISABLE TRIGGER ALL;

INSERT INTO public.subreddit_posts_sync_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, subreddit_id) VALUES ('0bec932a-be91-41c1-82cd-8cb1525521d5', '2022-04-19 23:55:14.881832-04', '2022-04-19 23:55:14.881832-04', 'job_status_not_started', NULL, 0, NULL, NULL, '2022-04-19 23:57:14.881245-04', 'f88d9749-8bd2-4918-aa97-98c72dbf9337');
INSERT INTO public.subreddit_posts_sync_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, subreddit_id) VALUES ('d6797e62-898e-48fe-a858-806c7ab2aa67', '2022-04-19 23:55:14.146602-04', '2022-04-19 23:55:14.891378-04', 'job_status_succeeded', NULL, 1, '2022-04-19 23:55:14.171336-04', NULL, '2022-04-19 23:55:14.146602-04', 'f88d9749-8bd2-4918-aa97-98c72dbf9337');


ALTER TABLE public.subreddit_posts_sync_jobs ENABLE TRIGGER ALL;


