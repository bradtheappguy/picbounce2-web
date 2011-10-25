extends 'api/base'
attributes(   :media_type, 
              :comment_count, 
              :view_count, 
              :text, 
              :deleted,
              :filter_name,
              :tw_crosspost,
              :fb_crosspost_pages )
attribute :code => :id
node(         :media_url)    {|post| post.post_url(:big)}
child(        :user)         { extends 'api/user_attr' }
child(        :comments =>:comments)      { extends 'api/comment_attr' }
