class HomesController < ApplicationController
  def index
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
    @user = current_user
  end

   def show
   @user = current_user
  end
end