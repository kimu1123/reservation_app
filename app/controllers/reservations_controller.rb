class ReservationsController < ApplicationController
  def index
    @reservations =current_user.reservations
    @user = current_user
  end
 

  def confirm
    @user = current_user
    @reservation = Reservation.new(reservation_params)  #新しいreservationインスタンスにformからのパラメーターを入れる
    @room = Room.find(params[:reservation][:room_id])   #roomの情報をroom_idを使って得る
    if @reservation.invalid?
      flash[:danger] = @reservation.errors.full_messages
			redirect_to room_path(@room.id)
		else
    @user_id = current_user.id
    @days = (@reservation.check_out - @reservation.check_in).to_i 
    @total_price = (@days * @room.price * @reservation.count_people   ) 
  end
end

  def create
    @user = current_user
    @room = Room.find(params[:reservation][:room_id])
    @user = User.find_by(params[:reservation][:room_id])
    @reservation = Reservation.new(params.require(:reservation).permit(:check_in, :check_out, :count_people, :user_id, :room_id ,:created_at , :updated_at))

    if @reservation.save
      flash[:notice] = "予約に成功しました"
      redirect_to reservations_path (@reservation)
    else
      flash.now[:alert] = "予約に失敗しました"
      render "rooms/show"
    end
  end
  
    def show
    end
  
    def edit
    end
  
    def update
    end
  
    def destroy
      @reservation = Reservation.find(params[:id])
      @reservation.destroy
      flash[:notice] = "施設の予約を削除しました"
      redirect_to reservations_path
    end


  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :count_people , :user_id, :room_id , :created_at , :updated_at)
  end
end
