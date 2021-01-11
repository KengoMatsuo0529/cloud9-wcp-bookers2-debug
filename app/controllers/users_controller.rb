class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]

  def create
    if @user.save
      NotificationMailer.send_confirm_to_user(@user).deliver
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end
  
  def following
    @user = User.find(params[:id])
    @users = User.followings
    render "follow"
  end
  
  def followers
    @user = User.find(params[:id])
    @users = User.followers
    render "follower"
  end 

  private
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
    redirect_to user_path(current_user.id)
    end
  end
  
end