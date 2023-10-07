class ApplicationController < ActionController::Base
# ログイン済ユーザーのみにアクセスを許可する

before_action :configure_permitted_parameters, if: :devise_controller?
   

    protected
  def configure_permitted_parameters
    # サインアップ時にnameのストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    
  end
end
   
private
def sign_in_required
    redirect_to new_user_session_url unless user_signed_in?
end
