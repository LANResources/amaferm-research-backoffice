class SessionsController < ApplicationController
  layout 'external', only: [:new, :create]
  skip_before_action :verify_authenticated, except: :destroy

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to welcome_url
    else
      flash.now[:error] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    sign_out
    flash[:notice] = "Successfully signed out."
    redirect_to root_url
  end
end
