require 'test_helper'

describe Api::ShelvesController do
  it 'redirects if no one is logged in' do
    get :index, format: :json
    response.status.must_equal 401
  end
end
