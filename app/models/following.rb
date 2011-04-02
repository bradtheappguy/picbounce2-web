class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => 'User'

  #validates_numerisality_of :status, :less_than => 2, :greater_than => -1     
end
