require 'erb'

class Notifier < ActionMailer::Base
  default from: "no-reply@amafermresearch.backofficeapps.com"

  def invitation(to: nil, from: nil)
    @user = to
    @inviter = from
    @register_url = rsvp_user_url(@user.id, ERB::Util.url_encode(@user.invite_token))

    mail  to: @user.email,
          from: 'Amaferm Research <invitations@amafermresearch.backofficeapps.com>',
          subject: 'Registration Invitation'
  end

  def password_reset(user)
    @user = user
    @reset_password_url = edit_password_reset_url(token: ERB::Util.url_encode(@user.password_reset_token))

    mail  to: @user.email,
          from: 'Amaferm Research <password-resets@amafermresearch.backofficeapps.com>',
          subject: "Password Reset"
  end
end
