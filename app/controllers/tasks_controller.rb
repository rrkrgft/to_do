class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def index
    if (params[:search] == "" || params[:search] == nil) && (params[:select] == "" || params[:select] == nil )
      if params[:sort_expired]
        @tasks = Task.where(user_id: current_user.id).order("deadline DESC").page(params[:page]).per(3)
      elsif params[:sort_priority]
        @tasks = Task.where(user_id: current_user.id).order("priority DESC").page(params[:page]).per(3)
      else
        @tasks = Task.where(user_id: current_user.id).order("created_at DESC").page(params[:page]).per(3)
      end
    else
      @tasks = Task.looks(params[:search], params[:select]).where(user_id: current_user.id).page(params[:page]).per(3)
    end
  end

  def show
    set_task
    user_check
  end

  def edit
    set_task
    user_check
  end

  def update
    set_task
    user_check
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    set_task
    user_check
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def user_check
    redirect_to tasks_path unless @task.user.id == current_user.id
  end
end
