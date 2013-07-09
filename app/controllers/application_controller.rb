class ApplicationController < ActionController::Base
  protect_from_forgery

  def ensure_shelf_visible(shelf)
    visible = BookShelf.for(current_user).include? shelf
    not_found unless visible
  end

  def ensure_book_on_shelf(book, shelf)
    on_shelf = shelf.books.include? book
    not_found unless on_shelf
  end

  def not_found
    render file: 'public/404', status: :not_found and return
  end
end
