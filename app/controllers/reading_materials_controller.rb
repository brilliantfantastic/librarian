class ReadingMaterialsController < ApplicationController
  def index
    @shelf = BookShelf.create
    @shelf.books << Book.new(name: 'Moby Dick', isbn: '9788420491936')
    @shelf.books << Book.new(name: 'The Swiss Family Robinson', isbn: '9780191505737')
  end
end
