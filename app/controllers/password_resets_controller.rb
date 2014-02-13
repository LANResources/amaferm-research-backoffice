class PasswordResetsController < ApplicationController
  skip_before_filter :verify_authenticated
  before_filter :find_user, only: [:edit, :update]
  layout 'registration'

  def new
  end
  
  def create
    user = User.find_by_email params[:email]
    Notifier.password_reset(user).deliver if user
    flash[:success] = "Email sent with password reset instructions."
    redirect_to login_url
  end

  def edit
  end

  def update
    if @user.reset_password user_attributes
      sign_in @user
      flash[:success] = "Password has been reset!"
      redirect_to root_url
    else
      render :edit
    end
  end

  private

  def find_user
    @user = User.find_by_password_reset_token! params[:token]
    if @user == :expired
      flash[:error] = "Password reset has expired."
      redirect_to new_password_reset_path
    end
  rescue
    flash[:error] = 'The password reset token is invalid. Please request a new one.'
    redirect_to login_url
  end

  def user_attributes
    params.require(:user).permit [:password, :password_confirmation]
  end
end
