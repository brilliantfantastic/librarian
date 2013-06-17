require "test_helper"

feature "Creating A Book Feature Test" do
  before :each do
    Book.delete_all
  end

  describe "with valid data" do
    before do
      visit new_book_path
      within('#new_book') do
        fill_in 'Book Name', with: 'Treasure Island'
        fill_in 'ISBN', with: 9780670846856
        click_on 'Create Book'
      end
    end

    scenario "adds a book to the database" do
      Book.count.must_equal 1
    end

    scenario "redirects to the book's show view" do
      current_path.must_equal book_path(Book.last)
    end

    scenario "show view must contain the book's name and isbn" do
      book = Book.last
      page.must_have_content book.name
      page.must_have_content book.isbn
    end
  end
end
