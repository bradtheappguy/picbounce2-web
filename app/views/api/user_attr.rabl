extends 'api/base'
attributes(
          :id, 
          :avatar,
          :verified,
          :tw_crosspost,
          :fb_crosspost_pages,
          :fb_like_target,
          :charity_name,
          :charity_link,
          :charity_pic,
          :name,
          :screen_name,
          :follower_count,
          :post_count)
node(:is_following)    { |user| user.following?(current_user) }
node(:followed_by)     { |user| user.followed_by?(current_user) }
