class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]

    if current_user
      current_user.providers << Provider.create!(:name => auth["provider"], :uid => auth['uid'])
    else
      user = User.with_provider(auth["provider"], auth["uid"]).first ||
             User.create_with_omniauth(auth)
      session[:user_id] = user.id
    end

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
