class SessionsController < ApplicationController

  def create
    @user = User.from_omniauth(env['omniauth.auth'])  
    @user.save                            
    session[:user_id] = @user.id 
    # params[:twitter] = env['omniauth.auth']
    redirect_to(root_path)
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end