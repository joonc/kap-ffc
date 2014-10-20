class MeetupsController < ApplicationController
  def index
    @meetups = Meetup.all.order("created_at DESC")
  end

  def create
    user1_id = params[:meetup][:user1_id]
    user2_id = User.find_by_email!(params[:meetup][:user2_email]).id
    Meetup.create(user1_id: user1_id, user2_id: user2_id)
    redirect_to user_path(user1_id)
  end
end
