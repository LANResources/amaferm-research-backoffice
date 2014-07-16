class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    authorize! User
    @users = policy_scope(User.order("#{sort_column} #{sort_direction}")).page(params[:page]).per_page(20)
  end

  def new
    @user = User.new
    authorize! @user
  end

  def edit
  end

  def create
    @user = User.new user_attributes
    authorize! @user

    if @user.save
      Notifier.invitation(to: @user, from: current_user).deliver
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    user_params = params[:user][:password].blank? ? user_attributes.except!(:password, :password_confirmation) : user_attributes

    if @user.update user_params
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  end

  private
    def set_user
      @user = current_resource
      authorize! @user
    end

    def current_resource
      if params[:action] == 'create'
        @current_resource ||= params[:user] if params[:user]
      else
        @current_resource ||= User.find(params[:id]) if params[:id]
      end
    end

    def user_attributes
      params.require(:user).permit *policy(@user || User).permitted_attributes
    end

    def sort_column
      super(User.column_names, 'last_name')
    end
end
