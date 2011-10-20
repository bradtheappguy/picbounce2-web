
object false => :response

code :url do
  request.url
end


code :next do
  if @posts && @posts.last
    timestamp = @posts.last.created
  end
  
  nextURL = request.url.gsub(/[?&]after=\d+/,"")
  if (nextURL.include?('?') == false)
      nextURL = nextURL + "?after=#{timestamp}"
    else
      nextURL = nextURL + "&after=#{timestamp}"
    end
    nextURL
end


child(@posts) {
  attributes :ptype, :uuid, :bounces_count, :comments_count, :tagged_people_count, :view_count, :caption, :created
  node(:likes_count) {|post| post.likes_count}
  node(:post_url) {|post| post.post_url(:big)}
  child(:comments) {
    attributes :text
    child(:user) {
      attributes :id, :display_name, :avatar
      attribute :raw_slug_text => :screen_name
    }
  }
  child(:user) {
    attributes :id, :display_name, :avatar
    attribute :raw_slug_text => :screen_name
  }
}

child(@user) {
  attributes :id, :display_name, :avatar
  attribute :raw_slug_text => :screen_name
  node(:is_following) { |user| user.is_following?(@current_user) }
  node(:followed_by) { |user| user.followed_by?(@current_user) }

  node(:follows_url) { |user| user_follows_url(user) }
  node(:following_count) { |user| user.following_count }

  node(:followed_by_url) { |user| user_followedby_url(user) }
  
  node(:followers_count) { |user| user.followed_by_count }
  node(:post_count ) { |user| user.post_count }
}


child(@people) {
  attributes :display_name, :avatar
  node(:screen_name) { |person| person.raw_slug_text}
  node(:profile_url) { |person| profile_url(person)}
}