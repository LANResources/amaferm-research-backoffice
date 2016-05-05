class RoleImpersonationsController < ApplicationController
  def new
    authorize! :role_impersonation

    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def create
    authorize! :role_impersonation

    current_user.impersonate! params[:role]
    session[:impersonating_role] = current_user.current_role if current_user.impersonating?

    redirect_to :back
  end

  def destroy
    authorize! :role_impersonation

    session[:impersonating_role] = nil
    current_user.reset_current_role!

    redirect_to :back
  end
end