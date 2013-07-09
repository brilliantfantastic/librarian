class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
  end

  def new
    @shelf = BookShelf.find(params[:shelf_id])
    @book = Book.new
  end

  def create
    @shelf = BookShelf.find(params[:shelf_id])
    @book = @shelf.books.create(params[:book])
    if @book.valid?
      redirect_to shelf_book_path(@shelf, @book)
    else
      render :new
    end
  end
end
