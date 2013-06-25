class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(params[:user])
    if @user.valid?
      redirect_to root_path
    else
      render :new
    end
  end
end