class SessionsController < ApplicationController
  skip_before_filter :restrict_non_visible_user

  def create
    auth = request.env["omniauth.auth"]

    if current_user
      provider = Provider.where(:name => auth["provider"], :uid => auth["uid"]).first

      if provider
        current_user.merge! provider.user
        current_user.providers << provider
      else
        current_user.providers << Provider.create!(:name => auth["provider"], :uid => auth['uid'])
      end

    else
      user = User.with_provider(auth["provider"], auth["uid"]).first ||
             User.create_with_omniauth(auth)
      session[:user_id] = user.id
    end

    redirect_to people_path, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
