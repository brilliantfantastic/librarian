class BookShelf
  attr_reader :books
  attr_accessor :space

  def initialize(attrs = {})
    @books = attrs[:books] ? attrs[:books] : []
    @space = attrs[:space] ? attrs[:space] : 12
  end

  def count
    @books.count
  end

  def full?
    count == @space
  end

  def empty?
    count == 0
  end

  def add_book(book)
    @books << book unless full?
  end

  def remove_book
    @books.delete_at(0) unless empty?
  end
end
