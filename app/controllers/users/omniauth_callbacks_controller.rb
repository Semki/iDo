class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    #raise request.env["omniauth.auth"].to_s
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"]['uid'], current_user)
 
    if @user.persisted?
      flash[:notice] = "Successfully registered"
      sign_in_and_redirect :user, @user
      
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
    
  end
end
