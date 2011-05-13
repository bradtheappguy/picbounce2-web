class Service < ActiveRecord::Base
  belongs_to :user

  def omniauth=(omni)
    if omni['credentials']
      self.secret = omni['credentials']['secret'] if omni['credentials']['secret']
      self.token  = omni['credentials']['token'] if omni['credentials']['token']
    end
    if omni['user_info']
      self.nickname  = omni['user_info']['nickname'] if omni['user_info']['nickname']
    end
  end

end
