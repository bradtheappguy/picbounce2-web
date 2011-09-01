class PhotoObserver < ActiveRecord::Observer
  observe :photo
  
  def after_create(photo)
    message = "#{photo.user.name} posted a photo."
    notify_followers(message)
  end

  
  def notify_followers(message)
    APN::Device.all.each do |device|
      notification = APN::Notification.create(:device => device, :badge => 0, :alert=>message)
      APN::Notification.send_notifications
    end
    
  end
end
