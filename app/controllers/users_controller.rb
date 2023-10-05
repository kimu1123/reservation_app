class UsersController < ApplicationController
 
  before_action :sign_in_required, only: [:show ,:own ,:update]

  def index
    @users = User.all
    @rooms = Room.all
  end


  def new
    @user = User.new
  end

  
  def show
    @user = current_user

  end


  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])
    if current_user.update(params.require(:user).permit(:icon, :name,:profile))
      flash[:notice] = "ユーザーIDが「#{@user.id}」の情報を更新しました"
      redirect_to users_show_path
    else
      flash.now[:alert] = "登録に失敗しました"
      render "edit"
    end
  end
end


private
    def user_params
      params.require(:user).permit(
        :icon,
        :name,
        :profile,
      )
    end
