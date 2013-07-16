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
    cover = params[:book].delete(:cover)
    cover_url = cover ? upload(cover) : nil
    @book = @shelf.books.create(params[:book].merge(cover_url: cover_url))
    if @book.valid?
      redirect_to shelf_book_path(@shelf, @book)
    else
      render :new
    end
  end

  private

  def upload(cover)
    file_path = Rails.root.join('public', 'uploads', cover.original_filename)
    File.open(file_path, 'wb') do |file|
      file.write(cover.read)
    end
    "/uploads/#{cover.original_filename}"
  end
end
