class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i(edit update show destroy)
  before_action :admin_rights
  def index 
    @users = User.all.includes(:tasks)
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

    def admin_rights
      unless admin?
        redirect_to tasks_path, notice: '管理者のみアクセスできます'
      end
    end
end
