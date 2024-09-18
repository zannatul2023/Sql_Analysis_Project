-- Social Media Interactions Analysis

use social_media;
-- Identifing Users by Location
select location ,count(*) as num_people from post
group by location
having length(location) < 15
order by num_people desc;

/*Mostly users'post came frome metro cities like Maharastra, Krnataka*/


-- Determine the top 10 Most used Hashtags
select hashtag_name,count(p.hashtag_id) as count from post_tags p
join hashtags h on h.hashtag_id = p.hashtag_id
group by p.hashtag_id
order by count desc limit 10
;

-- top 5 most followed hashtags
select hashtag_name , count(hf.hashtag_id) as count from hashtag_follow hf
join hashtags h on h.hashtag_id = hf.hashtag_id
group by hf.hashtag_id
order by count desc limit 5
;

-- Identify the Most Inactive User
select username,email from users
where user_id not in (select user_id from post);

-- Identify the Posts with the Most Likes
select caption,count(post_likes.post_id) as num_likes from post join post_likes on post.post_id = post_likes.post_id
group by post_likes.post_id
order by num_likes desc ;

-- Average Posts per User
select round(count(post_id)/count(distinct user_id),2) as avg_post from post;

-- Number of Logins per User
select username, count(login.user_id) as num_login from login
join users u on u.user_id = login.user_id 
group by login.user_id order by num_login desc;

-- User Who Liked Every Single Post
select user_id , count(user_id) as num_likes from post_likes
group by user_id
having num_likes = (select count(post_id) from post);

/*There is no user who liked all the post*/

-- Users Who Never Commented
select user_id from users where user_id not in (select user_id from comments);

-- User Who Commented twice or more on same Post
select * from comments c1 join comments c2 on c1.comment_id = c2.comment_id
where c1.post_id = c2.post_id and c1.user_id <> c2.user_id;
/*No users commented more than once on same post*/

-- user who commented on every post

select user_id , count(user_id) as num_com from comments
group by user_id 
having num_com = (select count(user_id) from users);

-- Users Not Followed by Anyone
select * from users where user_id not in (select followee_id as user_id from follows);

-- Users Not following Anyone
select * from users where user_id not in (select follower_id as user_id from follows);

-- Users who posted more than 5 times
select username, count(p.user_id) as num_posts from post p join users u on u.user_id = p.user_id
group by p.user_id
having num_posts >5;


-- Users with More than 40 Followers

 
select  username, count(follower_id) as num_followers from follows f join users u on f.follower_id = u.user_id
group by follower_id
having num_followers >40;
-- 
/*

14. Identify Users with More than 40 Followers
Write a query to find users who have more than 40 followers.
Hint: Group the followers and filter the result for those with a high follower
count.
*/

-- comments containing specific words like "good" or "beautiful."
select comment_text from comments
where comment_text regexp "good" or comment_text regexp "beautiful";

-- Longest Captions in Posts
select caption from post where length(caption) = (select max(length(caption)) from post);

