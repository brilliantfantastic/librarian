require 'test_helper'

feature 'Book shelf contents feature test' do
  scenario 'lists my favorite books by name' do
    visit root_path
    page.must_have_content 'Moby Dick'
    page.must_have_content 'The Swiss Family Robinson'
  end
end
