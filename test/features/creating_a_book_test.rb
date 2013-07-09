require "test_helper"

feature "Creating A Book Feature Test" do
  before :each do
    Book.delete_all
    @user = FactoryGirl.create :user, password: 'password'
    @shelf = FactoryGirl.create :book_shelf, user: @user
    signin @user, 'password'
  end

  describe "with valid data" do
    before do
      visit new_shelf_book_path(@shelf)
      within('#new_book') do
        fill_in 'Book Name', with: 'Treasure Island'
        fill_in 'ISBN', with: '9780670846856'
        click_on 'Create Book'
      end
    end

    scenario "adds a book to the database" do
      Book.count.must_equal 1
    end

    scenario "redirects to the book's show view" do
      current_path.must_equal shelf_book_path(@shelf, Book.last)
    end

    scenario "show view must contain the book's name and isbn" do
      book = Book.last
      page.must_have_content book.name
      page.must_have_content book.isbn
    end
  end

  describe "with invalid data" do
    before do
      Book.create(name: 'Treasure Island', isbn: '9780670846856')
      visit new_shelf_book_path(@shelf)
    end

    scenario "displays errors when submitting empty form" do
      within('#new_book') do
        click_on 'Create Book'
      end

      page.must_have_content "Name can't be blank"
      current_path.must_equal "/shelves/#{@shelf.id}/books"
    end

    scenario "displays error when book name is already taken" do
      within('#new_book') do
        fill_in 'Book Name', with: 'Treasure Island'
        fill_in 'ISBN', with: '9780670846856'
        click_on 'Create Book'
      end

      page.must_have_content 'Name has already been taken'
      current_path.must_equal "/shelves/#{@shelf.id}/books"
    end
  end
end
