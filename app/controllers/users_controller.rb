class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :can_not_new, only: [:new]
  def new
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = current_user.tasks
    if @user == current_user
      @user
    else
      redirect_to tasks_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def can_not_new
    redirect_to tasks_path if current_user.present?
  end
end
