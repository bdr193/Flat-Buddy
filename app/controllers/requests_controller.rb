class RequestsController < ApplicationController
  def index
    @requests = Request.all.where(user_id: current_user.id)
  end

  def show
    @request = Request.find(params[:id])
  end

  def new
  end

  def edit
  end
end
