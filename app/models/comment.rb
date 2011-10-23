class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :posts
  
  def created
    created_at.to_f
  end
end
