class SerchsController < ApplicationController
  
  def serch
    @user = User.find(params[:id])
  end
end
