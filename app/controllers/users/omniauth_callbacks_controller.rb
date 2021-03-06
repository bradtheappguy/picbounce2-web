class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  attr_accessor :omniauth_data
  attr_accessor :preexisting_authorization_token

  before_filter :set_omniauth_data
  
  
  def method_missing(provider)
    return super unless valid_provider?(provider)
    omniauthorize_additional_account || omniauth_sign_in || omniauth_sign_up
  end


  def signin_and_redirect_for_access_token
    puts "signing IN"
    return false unless preexisting_authorization_token.user
    sign_in(:user, preexisting_authorization_token.user)
    redirect_to "/users/auth/picbounce?auth_token=#{current_user.authentication_token}&user_id=#{current_user.id}" 
  end


  def omniauth_sign_in
    #todo merge by email if signing in with a new account for which we already have a user (match on email)
    return false unless preexisting_authorization_token
    flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth_data['provider']
    puts flash[:notice]
    signin_and_redirect_for_access_token
    true
  end


  def omniauth_sign_up
    unless omniauth_data.recursive_find_by_key("email").blank?
      user = User.find_or_initialize_by_email(:email => omniauth_data.recursive_find_by_key("email"))
    else
      user = User.new
    end

    user.apply_omniauth(omniauth_data)

    if user.save 
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth_data['provider']
      puts flash[:notice]
      sign_in(:user, user)
      redirect_to "/users/auth/picbounce?auth_token=#{user.authentication_token}&user_id=#{current_user.id}"
    else
      session[:omniauth] = omniauth_data.except('extra')
      signin_and_redirect_for_access_token
      #redirect_to new_user_registration_url
    end
  end


  def omniauthorize_additional_account
    return false if current_user.nil? 

    #todo signin not necessary, may mess up last sign in dates
    if preexisting_authorization_token && preexisting_authorization_token != current_user
      raise "This " +  omniauth_data['provider'] + " account is already linked to another ViaMe account. If you also own that ViaMe account, you need to login with it and modify your "+ omniauth_data['provider'] + " settings there first."
      
      
      flash[:alert] = "You have created two accounts and they can't be merged automatically. Email #{LIVE_PERSONS_EMAIL} for help."
      signin_and_redirect_for_access_token
    else

      current_user.apply_omniauth(omniauth_data)
      current_user.save
      msg = "Account connected"
      puts msg
      flash[:notice] = msg
      redirect_to "/users/auth/picbounce?auth_token=#{current_user.authentication_token}&user_id=#{current_user.id}"
    end
  end


  def set_omniauth_data
    self.omniauth_data = env["omniauth.auth"]
    provider = omniauth_data['provider'];
    self.preexisting_authorization_token = Service.find_by_provider_and_uid(provider, omniauth_data['uid'])
    #if provider == 'facebooksso' && !self.preexisting_authorization_token
    #  self.preexisting_authorization_token = Service.find_by_provider_and_uid('facebook', omniauth_data['uid'])
    #end
  end


  def valid_provider?(provider)
    !User.omniauth_providers.index(provider).nil?
  end
  

end
