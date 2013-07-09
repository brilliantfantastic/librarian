class BooksController < ApplicationController
  before_filter :require_login

  def show
    shelf = BookShelf.find(params[:shelf_id])
    ensure_shelf_visible shelf
    @book = Book.find(params[:id])
    ensure_book_on_shelf @book, shelf
  end

  def new
    @shelf = BookShelf.find(params[:shelf_id])
    ensure_shelf_visible @shelf
    @book = Book.new
  end

  def create
    @shelf = BookShelf.find(params[:shelf_id])
    ensure_shelf_visible @shelf
    @book = @shelf.books.create(params[:book])
    if @book.valid?
      redirect_to shelf_book_path(@shelf, @book)
    else
      render :new
    end
  end
end
