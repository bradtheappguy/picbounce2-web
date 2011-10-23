object false => :response
code :url do
  request.url
end

code :next do
  list = @posts || @users || @comments 

  nextURL = request.url.gsub(/[?&]after=\d+\.\d+/,"")
  isReversedOrder = (nextURL.length < request.url.length)
  nextURL = nextURL.gsub(/[?&]before=\d+\.\d+/,"")
  
  
  if !isReversedOrder
      timestamp = list.last.created unless !list || !list.last
  else
      timestamp = list.first.created unless !list || !list.first
  end 

  if (nextURL.include?('?') == false)
      nextURL = nextURL + "?before=#{timestamp}"
    else
      nextURL = nextURL + "&before=#{timestamp}"
    end
    nextURL
end

code :previous do
  list = @posts || @users || @comments 

  prevURL = request.url.gsub(/[?&]after=\d+\.\d+/,"")
  isReversedOrder = (prevURL.length < request.url.length)
  prevURL = prevURL.gsub(/[?&]before=\d+\.\d+/,"")
  
  
  if !isReversedOrder
      timestamp = list.first.created unless !list || !list.first
  else
      timestamp = list.last.created unless !list || !list.last
  end 

  if (prevURL.include?('?') == false)
      prevURL = prevURL + "?after=#{timestamp}"
    else
      prevURL = prevURL + "&after=#{timestamp}"
    end
    prevURL
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