class RemoveOldColumnsFromUsers < ActiveRecord::Migration
  def self.up
execute <<ENDSQL

drop table if exists temp_photos;
create table temp_photos (like photos);
alter table temp_photos drop column twitter_oauth_token; 
alter table temp_photos drop column twitter_oauth_secret; 
alter table temp_photos drop column twitter_avatar_url; 
alter table temp_photos drop column facebook_access_token; 
alter table temp_photos drop column facebook_user_id; 

insert into temp_photos 
(
id,
code,
created_at,
updated_at,
caption,
view_count,
user_agent,
uuid,
block,
facebook_post_status_code,
facebook_post_status_body,
facebook_photo_id,
app_version,
device_type,
os_version,
device_id,
device_language,
ip_address,
deleted,
twitter_post_id,
twitter_post_status_body,
twitter_post_status_code,
filter_name,
filter_version,
user_id
) 
SELECT
photos.id,
photos.code,
photos.created_at,
photos.updated_at,
photos.caption,
photos.view_count,
photos.user_agent,
photos.uuid,
photos.block,
photos.facebook_post_status_code,
photos.facebook_post_status_body,
photos.facebook_photo_id,
photos.app_version,
photos.device_type,
photos.os_version,
photos.device_id,
photos.device_language,
photos.ip_address,
photos.deleted,
photos.twitter_post_id,
photos.twitter_post_status_body,
photos.twitter_post_status_code,
photos.filter_name,
photos.filter_version,
users.id 
FROM photos INNER JOIN users on (photos.facebook_user_id = users.facebook_user_id) OR (photos.twitter_screen_name = users.twitter_screen_name);

alter sequence photos_id_seq OWNED BY NONE;
drop table photos;
alter table temp_photos rename to photos;


create index idx_photos_id on photos (id);

delete
from photos as outer_photos
where exists(
select inner_photos.id from photos as inner_photos
where inner_photos.id = outer_photos.id
group by id 
having count(id) > 1
);


ALTER TABLE photos alter column id set default nextval('photos_id_seq'::regclass);
ALTER TABLE photos ADD PRIMARY KEY (id);




ENDSQL
  end

  def self.down
    execute "drop table if exists temp_photos;"
  end
end
