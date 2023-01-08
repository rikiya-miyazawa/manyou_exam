class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(edit update show destroy)
  def index 
    @users = User.select(:name, :id)
  end
  
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: 'ユーザを作成'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update 
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'ユーザを更新'
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'ユーザを削除'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
