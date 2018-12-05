class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_from
  layout 'mailer'
end
