class TasksController < ApplicationController
  before_action :set_task, only: %i(show edit update destroy)
  def index
    @tasks = current_user.tasks
    if params[:sort_end_date].present?
      @tasks = current_user.tasks.sort_end_date.page(params[:page]).per(5)
    elsif params[:sort_priority].present?
      @tasks = current_user.tasks.sort_priority.page(params[:page]).per(5)
    elsif params[:task].present?
        if params[:task].present? && params[:task][:start_status].present?
          @tasks = current_user.tasks.title_search(params[:task][:title])
                        .status_search(params[:task][:start_status])
                        .page(params[:page]).per(2)
        elsif params[:task].present? 
          @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page]).per(2)
        elsif params[:task][:start_status].present?
          @tasks = current_user.tasks.status_search(status).page(params[:page]).per(2)
        end
    else
      @tasks = current_user.tasks.latest.page(params[:page]).per(5)
    end
  end

  def show
  end
  
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title, :content, :end_date, :start_status, :priority)
  end
end
