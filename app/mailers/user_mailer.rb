class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to Lunch and Learn!')
  end
end
