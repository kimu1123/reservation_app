class UsersController < ApplicationController

  before_action :sign_in_required, only: [:show]
  
  def new
    @user = User.new
  end

  
  def show
    @user = current_user
  end
  end


