ActiveRecord::Base.logger = Logger.new(STDOUT)
class Dm < ActiveRecord::Migration
  def self.up
    execute <<ENDOFSQL
delete from users;
DROP TABLE IF EXISTS temp_users;
DROP TABLE IF EXISTS temp_multiple_twitter;
DROP TABLE IF EXISTS temp_multiple_facebook;
DROP TABLE IF EXISTS temp_latest_facebook_data;

CREATE TABLE temp_users (
  "id" int4 DEFAULT NULL,
    "name" varchar(255) DEFAULT NULL,
      "created_at" timestamp(6) DEFAULT NULL,
        "updated_at" timestamp(6) DEFAULT NULL,
          "twitter_screen_name" varchar(255) DEFAULT NULL,
            "twitter_oauth_token" varchar(255) DEFAULT NULL,
              "twitter_oauth_secret" varchar(255) DEFAULT NULL,
                "twitter_avatar_url" varchar(255) DEFAULT NULL,
                  "facebook_access_token" varchar(255) DEFAULT NULL,
                    "facebook_user_id" varchar(255) DEFAULT NULL
                    )
WITH (OIDS=FALSE);


-- insert people with both mappings
insert into temp_users (twitter_screen_name, facebook_user_id )
select distinct twitter_screen_name, facebook_user_id 
from photos 
where twitter_screen_name is not null and facebook_user_id is not null
and twitter_screen_name<>'' and facebook_user_id<>'';

-- insert people with twitter-only mapping
insert into temp_users (twitter_screen_name )
select distinct twitter_screen_name 
from photos 
where (facebook_user_id is null or facebook_user_id = '') 
and twitter_screen_name not in (select twitter_screen_name from temp_users) 
and twitter_screen_name <> '';

-- insert people with facebook-only mapping
insert into temp_users (facebook_user_id )
select distinct facebook_user_id 
from photos 
where (twitter_screen_name is null or twitter_screen_name = '') 
and facebook_user_id not in (select facebook_user_id from temp_users where facebook_user_id is not null);




--identify duplicate twitter account and save them aside
select facebook_user_id
into temp_multiple_twitter
from temp_users where facebook_user_id is not null 
group by facebook_user_id 
having count(*) > 1;

--remove them all
delete from temp_users where facebook_user_id in (select facebook_user_id from temp_multiple_twitter);


--add back facebook_ids with latest twitter_screen_name
insert into temp_users (twitter_screen_name, facebook_user_id )
select s.twitter_screen_name,s.facebook_user_id
from temp_multiple_twitter t
JOIN photos s
ON s.facebook_user_id = t.facebook_user_id
where s.twitter_screen_name is not null and twitter_screen_name <> ''
and created_at = (select max(created_at) from photos pp where pp.facebook_user_id = t.facebook_user_id and  pp.twitter_screen_name is not null and pp.twitter_screen_name <> '');

--check if all duplicates are gone
select facebook_user_id
from temp_users where facebook_user_id is not null 
group by facebook_user_id 
having count(*) > 1;



--identify duplicate facebook accounts and save them aside
select twitter_screen_name
into temp_multiple_facebook
from temp_users where twitter_screen_name is not null 
group by twitter_screen_name 
having count(*) > 1;

--remove them all
delete from temp_users where twitter_screen_name in (select twitter_screen_name from temp_multiple_facebook);

--add back twitter_screen_name with latest facebook_user_id
insert into temp_users (twitter_screen_name, facebook_user_id )
select s.twitter_screen_name,s.facebook_user_id
from temp_multiple_facebook t
JOIN photos s
ON s.twitter_screen_name = t.twitter_screen_name
where s.facebook_user_id is not null and facebook_user_id <> ''
and created_at = (select max(created_at) from photos pp where pp.twitter_screen_name = t.twitter_screen_name and  pp.facebook_user_id is not null and pp.facebook_user_id <> '');

--check if all duplicates are gone
select twitter_screen_name
from temp_users where twitter_screen_name is not null 
group by twitter_screen_name 
having count(*) > 1;



-- get latest facebook user data
drop index if exists idx1;
drop index if exists idx2;
create index idx1 on temp_users(facebook_user_id);
create index idx2 on photos(facebook_user_id);

select facebook_user_id, facebook_access_token 
into temp_latest_facebook_data
from photos s
where 
 s.created_at = (select max(created_at) from photos pp where pp.facebook_user_id = s.facebook_user_id) ;

 create index idx3 on temp_latest_facebook_data(facebook_user_id);



  -- get latest twitter user data
  drop index if exists idx5;
  drop index if exists idx6;
  create index idx5 on temp_users(twitter_screen_name);
  create index idx6 on photos(twitter_screen_name);

  drop table if exists temp_latest_twitter_data;

  select twitter_screen_name,twitter_oauth_token,twitter_oauth_secret,twitter_avatar_url
  into temp_latest_twitter_data
  from photos s
  where 
   s.created_at = (select max(created_at) from photos pp where pp.twitter_screen_name = s.twitter_screen_name) ;

   create index idx7 on temp_latest_twitter_data(twitter_screen_name);

   -- merge all results
   insert into users (facebook_user_id, twitter_screen_name, facebook_access_token,twitter_oauth_token,twitter_oauth_secret,twitter_avatar_url)
   select a.facebook_user_id, a.twitter_screen_name, b.facebook_access_token, c.twitter_oauth_token, c.twitter_oauth_secret, c.twitter_avatar_url
   from temp_users a
   left outer join temp_latest_facebook_data b
   on a.facebook_user_id=b.facebook_user_id
   left outer join temp_latest_twitter_data c
   on a.twitter_screen_name=c.twitter_screen_name;

   -- DROP temp table
   drop table temp_users;
   drop table temp_multiple_twitter;
   drop table temp_multiple_facebook;
ENDOFSQL
  end

  def self.down
  end
end
