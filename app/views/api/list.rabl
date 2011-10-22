object false => :response
code :url do
  request.url
end

code :next do
  if @posts && @posts.last
    timestamp = @posts.last.created_at
  elsif @users && @users.last
    timestamp = @users.last.created_at
  elsif @comments && @comments.last
    timestamp = @comments.last.created_at
  end
  
  nextURL = request.url.gsub(/[?&]after=\d+/,"")
  if (nextURL.include?('?') == false)
      nextURL = nextURL + "?after=#{timestamp}"
    else
      nextURL = nextURL + "&after=#{timestamp}"
    end
    nextURL
end

code :previous do
  if @posts && @posts.last
    timestamp = @posts.first.created_at
  elsif @users && @users.last
    timestamp = @users.first.created_at
  elsif @comments && @comments.last
    timestamp = @comments.first.created_at
  end
  
  nextURL = request.url.gsub(/[?&]after=\d+/,"")
  if (nextURL.include?('?') == false)
      nextURL = nextURL + "?before=#{timestamp}"
    else
      nextURL = nextURL + "&before=#{timestamp}"
    end
    nextURL
end

child(@posts) {
  extends 'api/post_attr'
}

child(@users) {
  extends 'api/user_attr'
}

child(@comments) {
  extends 'api/comment_attr'
}