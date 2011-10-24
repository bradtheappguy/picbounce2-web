object false => :response

renderPostsAsAList = (@posts != nil)
renderUsersAsAList = (@users != nil)
renderCommentsAsAList = (@comments != nil)

if renderPostsAsAList 
  child(renderPostsAsAList =>:posts) do 
    extends 'api/list'
  end
end
if renderUsersAsAList 
  child(renderUsersAsAList =>:users) do 
    extends 'api/list'
  end
end
if renderCommentsAsAList
  child(renderCommentsAsAList =>:comments ) do 
    extends 'api/list'
  end
end


child(@post) {
  extends 'api/post_attr'
}

child(@user) {
  extends 'api/user_attr'
}

child (@comment) { 
  extends 'api/comment_attr'
}