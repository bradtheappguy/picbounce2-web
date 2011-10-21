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
  extends 'api/post'
}