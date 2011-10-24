extends 'api/base'
attributes(  :ptype, 
              :comments_count, 
              :view_count, 
              :caption, 
              :deleted,
              :filter_name,
              :twitter_cross_post,
              :facebook_cross_post_pages )
attribute :code => :id
node(         :media_url)    {|post| post.post_url(:big)}
child(        :user)         { extends 'api/user_attr' }
child(        :comments =>:comments)      { extends 'api/comment_attr' }
