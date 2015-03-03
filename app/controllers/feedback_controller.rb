class FeedbackController < ApplicationController
  def new
    respond_with_js
  end

  def create
    respond_with_js do
      feedback = Feedback.new params[:feedback]
      feedback.user = current_user
      Notifier.feedback_submission(feedback).deliver_now
    end
  end
end
