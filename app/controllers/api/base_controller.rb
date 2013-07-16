class Api::BaseController < ApplicationController
  before_filter :login_from_http_basic
  respond_to :json

  rescue_from ActiveRecord::RecordNotFound do |exeception|
    not_found_response
  end

  private

  def login_from_http_basic
    authenticate_with_http_basic do |username, password|
      @current_user = user_class.authenticate(username, password)
      auto_login(@current_user) if @current_user
    end
    @current_user ? @current_user : not_authorized_response
  end

  def not_authorized_response
    render nothing: true, status: :unauthorized and return
  end

  def not_found_response
    render nothing: true, status: :not_found
  end
end
