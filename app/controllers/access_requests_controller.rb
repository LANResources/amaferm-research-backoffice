class AccessRequestsController < ApplicationController
  respond_to :js

  def new
    @access_request = AccessRequest.new
  end

  def create
    @access_request = AccessRequest.new access_request_attributes
    if @access_request.save
      Notifier.access_request_submission(@access_request).deliver
    else
      render :error
    end
  end

  private

  def access_request_attributes
    params.require(:access_request).permit *policy(@access_request || AccessRequest).permitted_attributes
  end
end
