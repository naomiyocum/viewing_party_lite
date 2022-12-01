# frozen_string_literal: true

class UsersController < ApplicationController
  def discover
    @user = User.find(params[:id])
  end

  def new; end

  def show
    @user = User.find(params[:id])
    @view_parties = @user.view_parties.order('datetime')
  end

  def create
    new_user = User.new(user_params)

    if new_user.save
      redirect_to user_path(new_user)
    else
      redirect_to register_path
      flash[:alert] = new_user.errors.full_messages.to_sentence
    end
  end

  private

  def user_params
    params.permit(:name, :email)
  end
end
