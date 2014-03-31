class FeedbackController < ApplicationController
  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    feedback = Feedback.new params[:feedback]
    feedback.user = current_user
    Notifier.feedback_submission(feedback).deliver

    respond_to do |format|
      format.js
    end
  end
end
