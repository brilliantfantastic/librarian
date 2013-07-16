class Api::ShelvesController < Api::BaseController

  def index
    respond_with BookShelf.for(current_user)
  end

  def show
    respond_with BookShelf.for(current_user).find(params[:id])
  end

  def create
    params[:book_shelf].merge!(user_id: current_user.id)
    shelf = BookShelf.create(params[:book_shelf])
    respond_with shelf, location: nil
  end

end
