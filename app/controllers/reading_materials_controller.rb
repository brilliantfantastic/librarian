class ReadingMaterialsController < ApplicationController
  def index
    @shelf = BookShelf.new
    @shelf.add_book Book.new(name: 'Moby Dick', isbn: 9788420491936)
    @shelf.add_book Book.new(name: 'The Swiss Family Robinson', isbn: 9780191505737)
  end
end
