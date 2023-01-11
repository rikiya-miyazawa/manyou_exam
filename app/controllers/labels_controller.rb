class LabelsController < ApplicationController
  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to admin_users_path, notice: 'ラベルを作成'
    else
      render :new
    end
  end

  def destroy
    @label = Label.find(params[:id])
    @label.destroy
    redirect_to admin_users_path, notice: 'ラベルを削除'
  end

  private

  def label_params
    params.require(:label).permit(:name)
  end

end
