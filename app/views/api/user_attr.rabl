extends 'api/base'
attributes(
          :id, 
          :avatar,
          :verified,
          :facebook_cross_post_pages,
          :twitter_cross_post,
          :facebook_like_target,
          :charity_name,
          :charity_link,
          :charity_pic)
node(:name)            { |user| user.display_name }
node(:screen_name)     { |user| user.slug }
node(:is_following)    { |user| user.is_following?(@current_user) }
node(:followed_by)     { |user| user.followed_by?(@current_user) }
node(:followers_count) { |user| user.followed_by_count }
node(:post_count)      { |user| user.post_count }
