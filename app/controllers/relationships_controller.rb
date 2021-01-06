class RelationshipsController < ApplicationController
  
  before_action :authenticate_user!
  
  def create
    current_user.follow(params[:id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unfollow(params[:id]) 
    redirect_back(fallback_location: root_path)
  end
end
