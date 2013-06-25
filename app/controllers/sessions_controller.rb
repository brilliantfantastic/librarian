class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:user][:email], params[:user][:password])
    unless @user
      @user = User.new
      flash[:error] = 'Invalid email or password'
      render :new and return
    end
    redirect_to root_path, notice: "Welcome #{@user.username}"
  end
end
