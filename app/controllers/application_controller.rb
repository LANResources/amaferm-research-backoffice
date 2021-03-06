class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit
  include SessionsHelper

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :check_if_referred_from_amaferm_dot_com

  private

  def verify_authenticated
    unless signed_in?
      deny_access
      false
    end
  end

  def user_not_authorized
    deny_access
  end

  def respond_with_js(&block)
    respond_to do |format|
      format.html { render nothing: true }
      format.js { yield if block_given? }
    end
  end

  def sort_column(columns, default)
    columns.include?(params[:sort]) ? params[:sort] : default
  end
  helper_method :sort_column

  def sort_direction(default = 'asc')
    %w[asc desc].include?(params[:direction]) ? params[:direction] : default
  end
  helper_method :sort_direction

  def check_if_referred_from_amaferm_dot_com
    referred_from_amaferm! if request.referer =~ /amaferm.com/i
  end
end
