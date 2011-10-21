attributes :id, :avatar
node(:name) { |user| user.display_name }
node(:screen_name) { |user| user.display_name }
node(:is_following) { |user| user.is_following?(@current_user) }
node(:followed_by) { |user| user.followed_by?(@current_user) }
node(:followers_count) { |user| user.followed_by_count }
node(:post_count ) { |user| user.post_count }
