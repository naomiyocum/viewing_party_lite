# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :validate_user, only: %i[show]

  def discover; end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
      flash[:success] = "Welcome, #{user.name}!"
    else
      flash[:error] = 'Sorry, your credentials do not match.'
      render :login_form
    end
  end

  def logout_user
    session.destroy
    redirect_to root_path
    flash[:alert] = 'See ya later!'
  end

  def new; end

  def show
    @view_parties = @user.view_parties.order('datetime')
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      session[:user_id] = new_user.id
      UserMailer.with(user: new_user).welcome_email.deliver_later
      redirect_to dashboard_path
      flash[:success] = "Welcome, #{new_user.name}!"
    else
      redirect_to register_path
      flash[:alert] = new_user.errors.full_messages.to_sentence
    end
  end

  private

  def validate_user
    if current_user.nil?
      redirect_to root_path
      flash[:alert] = 'You must be logged in to access your dashboard'
    else
      find_user
    end
  end

  def find_user
    @user = current_user
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
