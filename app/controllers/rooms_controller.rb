class RoomsController < ApplicationController

  def index
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
    @user = current_user
  end

  def new
    @room = Room.new
    @user = current_user
   end

   def create
    @user = current_user
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
    @user = current_user
    @room = Room.find(params[:id])
    @reservation = Reservation.new
    @q = Room.ransack(params[:q])
    @rooms = @q.result(distinct: true)
  end


  def edit
    @room = Room.find(params[:id])
    @user = current_user
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "宿泊施設を更新しました"
      redirect_to @room
    else
      flash.now[:alert] = "宿泊施設の更新に失敗しました"
      render :edit , status: :unprocessable_entity
    end
  end

  def destroy
    @user = current_user
    @room = Room.find(params[:id])
    @room.destroy
      flash[:notice] = "ユーザーを削除しました"
      redirect_back(fallback_location: root_path)
  end

  def own
    @user = User.find(params[:id])
    @rooms = @user.rooms
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