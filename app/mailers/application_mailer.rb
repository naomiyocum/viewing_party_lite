# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'LandLnotifs@gmail.com'
  layout 'mailer'
end
