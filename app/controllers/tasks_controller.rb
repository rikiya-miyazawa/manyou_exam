class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    @tasks = Task.all
    if params[:sort_end_date].present?
      @tasks = Task.sort_end_date
    elsif params[:task].present?
        if params[:task].present? && params[:task][:start_status].present?
          @tasks = Task.title_search(params[:task][:title]).status_search(params[:task][:start_status])
        elsif params[:task].present? 
          @tasks = Task.title_search(params[:task][:title])
        elsif params[:task][:start_status].present?
          @tasks = Task.status_search(status)
        end
    else
      @tasks = Task.latest
    end
  end

  def show
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'タスクを追加しました'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを編集しました'
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :content, :end_date, :start_status)
  end
end
