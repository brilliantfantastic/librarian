class Api::ShelvesController < Api::BaseController

  def index
    respond_with BookShelf.for(current_user)
  end

  def show
    respond_with BookShelf.for(current_user).find(params[:id])
  end

end
