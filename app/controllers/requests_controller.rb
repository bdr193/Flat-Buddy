class RequestsController < ApplicationController
  def index
    @requests = Request.where(user_id: current_user.id)
  end

  def show
  end

  def new
  end

  def edit
  end
end
