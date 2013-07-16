require 'test_helper'

describe Api::ShelvesController do
  it 'rejects if no one is logged in' do
    get :index, format: :json
    response.status.must_equal 401
  end

  describe 'while authenticated' do
    before do
      @user = FactoryGirl.create :user, password: 'password'
      @shelf = FactoryGirl.create :book_shelf, user: @user
      basic_auth @user, 'password'
    end

    describe "GET 'index'" do
      it "returns a serialized list of the user's shelves" do
        get :index, format: :json
        response.success?.must_equal true
        body = JSON.parse response.body
        body.count.must_equal 1
        body[0]['name'].must_equal @shelf.name
        body[0]['user_id'].must_equal @shelf.user_id
      end
    end
  end
end
