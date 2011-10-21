attributes :ptype, :uuid, :bounces_count, :comments_count, :tagged_people_count, :view_count, :caption, :created
child :user => :user do
  extends 'api/user'
end
node(:likes_count) {|post| post.likes_count}
node(:post_url) {|post| post.post_url(:big)}
child(:comments) {
  extends 'api/comment'
}