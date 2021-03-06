ActionMailer::Base.smtp_settings = {
  address:              ENV['MAIL_ADDRESS'],
  port:                 ENV['MAIL_PORT'].try(:to_i),
  domain:               ENV['MAIL_DOMAIN'],
  user_name:            ENV['MAIL_USER_NAME'],
  password:             ENV['MAIL_PASSWORD'],
  authentication:       :plain,
  enable_starttls_auto: true,
  openssl_verify_mode:  'none'
}
