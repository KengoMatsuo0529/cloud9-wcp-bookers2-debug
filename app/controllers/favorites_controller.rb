class FavoritesController < ApplicationController
  
  before_action :set_varidates
  
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_back(fallback_location: root_path)
  end
  
  private
  def set_varidates
    @book = Book.find(params[:book_id])
    @id_name = "create-create-#{@book.id}"
  end
end
