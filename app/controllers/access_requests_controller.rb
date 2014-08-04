class AccessRequestsController < ApplicationController

  def new
    respond_with_js do 
      @access_request = AccessRequest.new
    end
  end

  def create
    respond_with_js do
      @access_request = AccessRequest.new access_request_attributes
      if @access_request.save
        Notifier.access_request_submission(@access_request).deliver
      else
        render :error
      end
    end
  end

  private

  def access_request_attributes
    params.require(:access_request).permit *policy(@access_request || AccessRequest).permitted_attributes
  end
end
