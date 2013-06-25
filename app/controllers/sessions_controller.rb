class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    redirect_to root_path, notice: "Welcome #{@user.username}"
  end
end
