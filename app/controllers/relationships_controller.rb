class RelationshipsController < ApplicationController

  before_action :authenticate_user!

  def create
    current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def follow
    @user = User.find(params[:user_id])
  end

  def follower
    @user = User.find(params[:user_id])
  end

end
