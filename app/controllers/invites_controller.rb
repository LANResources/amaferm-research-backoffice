class InvitesController < ApplicationController
  skip_before_filter :verify_authenticated, only: [:edit, :update]
  before_filter :verify_invitation, only: [:edit, :update]
  before_filter :authenticate_registration, only: :update
  layout 'registration', only: [:edit, :update]

  def create
    @user = User.find(params[:id]) if params[:id]
    authorize_invite

    Notifier.invitation(to: @user, from: current_user).deliver if @user

    respond_to do |format|
      flash[:notice] = "Successfully sent an invitation to #{@user.full_name}."
      format.html { redirect_to users_path }
      format.js
    end
  end

  def edit
  end

  def update
    authorize_invite

    if @user.register user_attributes
      redirect_to root_url, notice: 'Success! You are now a registered user of the Amaferm Research BackOffice.'
    else
      sign_out
      render action: 'edit'
    end
  rescue
    sign_out
    render action: 'edit'
  end

  private

  def verify_invitation
    deny_access if signed_in?
    @user = User.find_by_invite_token! params[:invite_token]
    raise unless @user.id == params[:id].try(:to_i)
  rescue
    flash[:error] = "The invitation link you're attempting to use is not valid."
    redirect_to login_path
  end

  def authenticate_registration
    sign_in @user if @user
    @user = current_user
    verify_authenticated
  end

  def authorize_invite
    raise Pundit::NotAuthorizedError unless InvitePolicy.new(current_user, @user).send("#{params[:action]}?")
  end

  def user_attributes
    params.require(:user).permit *policy(@user || User).permitted_attributes
  end
end
