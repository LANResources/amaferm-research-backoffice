require 'erb'

class Notifier < ActionMailer::Base
  default from: "no-reply@amafermresearch.backofficeapps.com"

  def invitation(to: nil, from: nil)
    @user = to
    @inviter = from
    @register_url = rsvp_user_url(@user.id, @user.invite_token)

    mail  to: @user.email,
          from: 'Research Center <invitations@amafermresearch.backofficeapps.com>',
          subject: 'Registration Invitation'
  end

  def password_reset(user)
    @user = user
    @reset_password_url = edit_password_reset_url(token: ERB::Util.url_encode(@user.password_reset_token))

    mail  to: @user.email,
          from: 'Research Center <password-resets@amafermresearch.backofficeapps.com>',
          subject: "Password Reset"
  end

  def feedback_submission(feedback)
    @feedback = feedback

    mail  to: 'lwhitacre@biozymeinc.com',
          from: 'Research Center <contact-us@amafermresearch.backofficeapps.com>',
          subject: "Amaferm Research Center Contact Submission"
  end

  def access_request_submission(access_request)
    @access_request = access_request

    mail  to: 'mbaker@biozymeinc.com',
          from: 'Research Center <access-requests@amafermresearch.backofficeapps.com>',
          subject: "Research Center Access Request"
  end
end
