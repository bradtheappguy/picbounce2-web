extends 'api/base'
attributes(  :ptype, 
              :code, 
              :comments_count, 
              :view_count, 
              :caption, 
              :deleted,
              :filter_name,
              :twitter_cross_post,
              :facebook_cross_post_pages )
node(         :media_url)    {|post| post.post_url(:big)}
child(        :user)         { extends 'api/user_attr' }
child(        :comments)      { extends 'api/comment_attr' }
