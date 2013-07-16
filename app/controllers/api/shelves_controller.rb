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

  def update
    shelf = BookShelf.update(params[:id], params[:book_shelf])
    render json: shelf and return if shelf.valid?
    respond_with shelf
  end

  def destroy
    respond_with BookShelf.for(current_user).destroy(params[:id])
  end

end
