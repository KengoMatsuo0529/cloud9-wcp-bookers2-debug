class BooksController < ApplicationController
  
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  
  def new
    @book = Book.new
  end
  
  def show
    @books = Book.all
    @book = Book.new
    @users = User.all
    @book_show = Book.find(params[:id])
    @user = @book_show.user
  end

  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      @users = User.all
      @user = current_user
      render :index
    end
  end

  def edit
    @books = Book.all
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      @books = Book.all
      @users = User.all
      @user = current_user
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.permit(:title, :body)
  end
  
  def correct_user
    book = Book.find(params[:id])
    if current_user.id != book.user.id
    redirect_to books_path
    end
  end
  
end
