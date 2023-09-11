class RoomsController < ApplicationController
  def index
    @user = current_user
    @rooms = Room.all

  end

  def new
    @room = Room.new
   end

   def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id 
      if @room.save
        flash[:notice] = "新規登録しました"
        redirect_to @room
      else
        flash.now[:alert] = "登録に失敗しました"
        render "new"
      end
  end

  def show
    @room = Room.find(params[:id])
    @user = @room.user
    @reservation=Reservation.new
  end

  def edit
    @room = Room.find(params[:id])
  end


  private
    def room_params
      params.require(:room).permit(
        :image,
        :name,
        :introduction,
        :price,
        :address,
        :user_id,
      )
    end

end