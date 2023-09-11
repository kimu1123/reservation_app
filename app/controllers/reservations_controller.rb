class ReservationsController < ApplicationController
  def index
    @reservations =current_user.reservations
  end
    
  def new
    @user = current_user
    @reservation = Reservation.new
  end

  def confirm
    @reservation = Reservation.new(reservation_params) 
    @room = Room.find(params[:reservation][:room_id])  
    @user = current_user
    if @reservation.check_in. == nil
      redirect_to @room, alert:"開始日を入力してください" and return
    end

    if @reservation.check_out. == nil
      redirect_to @room, alert:"終了日を入力してください" and return
    end
  
    if @reservation.check_out < @reservation.check_in
      redirect_to @room, alert:"終了日は開始日以降の日付にしてください" and return
    end
    @days = (@reservation.check_out - @reservation.check_in).to_i 
    @total_price = (@days * @room.price * @reservation.count_people   ) 
  end
end


    def create
      @reservation = Reservation.new(params.require(:reservation).permit(:check_in, :check_out, :people_count, :user_id, :room_id ,:created_at , :updated_at))
      if @reservation.save
        redirect_to :reservations
      else
        render "confirm"
      end
    end
  
  
    def show
    end
  
    def edit
    end
  
    def update
    end
  
    def destroy
    end
  

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :count_people, :user_id, :room_id , :created_at , :updated_at)
  end

  

