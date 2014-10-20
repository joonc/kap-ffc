class UsersController < ApplicationController
  before_filter :is_admin?, only: [:index, :destroy, :toggle_mute]

  def index
    @users = User.all.order("created_at DESC")
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.year = params[:user][:year]
    user.team = params[:user][:team]
    user.fun_fact = params[:user][:fun_fact]
    user.save
    render json: { result: "success" }
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path
  end

  def toggle_mute
    user = User.find(params[:id])
    user.mute = !user.mute
    user.save
    redirect_to users_path
  end

  def send_reminder
    UserMailer.send_time_input_reminder(current_user).deliver
    render json: { result: "success" }
  end

  def thankyou
    render inline: "You have already signed up.
                    <%= link_to 'Sign out', sign_out_path %>"
  end
end
