class ShelvesController < ApplicationController
  before_filter :require_login

  def index
    @shelves = BookShelf.for(current_user)
  end

  def show
    @shelf = BookShelf.find(params[:id])
  end

  def new
    @shelf = BookShelf.new
  end

  def create
    params[:book_shelf].merge!(user_id: current_user.id)
    @shelf = BookShelf.create(params[:book_shelf])
    if @shelf.valid?
      redirect_to shelf_path(@shelf)
    else
      render :new
    end
  end
end
