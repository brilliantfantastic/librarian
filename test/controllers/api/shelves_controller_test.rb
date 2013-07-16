require 'test_helper'

describe Api::ShelvesController do
  describe 'while unauthenticated' do
    it 'rejects for index' do
      get :index, format: :json
      response.status.must_equal 401
    end

    it 'rejects for show' do
      get :show, id: 1, format: :json
      response.status.must_equal 401
    end

    it 'rejects for create' do
      post :create, format: :json
      response.status.must_equal 401
    end

    it 'rejects for udpate' do
      put :update, id: 1, format: :json
      response.status.must_equal 401
    end
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

    describe "GET 'show'" do
      it 'returns a serialized bookshelf' do
        get :show, id: @shelf, format: :json
        response.success?.must_equal true
        body = JSON.parse response.body
        body['name'].must_equal @shelf.name
        body['user_id'].must_equal @shelf.user_id
      end

      it 'returns a 404 if the shelf does not exist' do
        get :show, id: -1, format: :json
        response.status.must_equal 404
      end
    end

    describe "POST 'create'" do
      it 'returns the created serialized bookshelf' do
        book_shelf = FactoryGirl.build :book_shelf, user: nil
        json = book_shelf.as_json.delete_if do |k, v|
          k == 'created_at' || k == 'updated_at'
        end
        post :create, format: :json, book_shelf: json
        response.status.must_equal 201
        body = JSON.parse response.body
        body['name'].must_equal book_shelf.name
        body['user_id'].must_equal @user.id
      end

      it 'returns a 422 if the bookshelf is invalid' do
        book_shelf = FactoryGirl.build :book_shelf, user: nil, name: nil
        json = book_shelf.as_json.delete_if do |k, v|
          k == 'created_at' || k == 'updated_at'
        end
        post :create, format: :json, book_shelf: json
        response.status.must_equal 422
      end
    end

    describe "PUT 'update'" do
      it 'returns the updated serialized bookshelf' do
        @shelf.name = 'Cooking'
        json = @shelf.as_json.delete_if do |k, v|
          k == 'created_at' || k == 'updated_at'
        end
        put :update, format: :json, id: @shelf, book_shelf: json
        response.success?.must_equal true
        body = JSON.parse response.body
        body['name'].must_equal @shelf.name
      end

      it 'returns a 422 if the bookshelf is invalid' do
        @shelf.name = ''
        json = @shelf.as_json.delete_if do |k, v|
          k == 'created_at' || k == 'updated_at'
        end
        put :update, format: :json, id: @shelf, book_shelf: json
        response.status.must_equal 422
      end

      it 'returns a 404 if the bookshelf does not exist' do
        put :update, format: :json, id: -1
        response.status.must_equal 404
      end
    end
  end
end
