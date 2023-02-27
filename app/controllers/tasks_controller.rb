class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "タスクを登録しました"
    else
      render :new
    end
  end

  def index
    @task = Task.all
  end

  def show
    set_task
  end

  def edit
    set_task
  end

  def create
    set_task
    if @task.update(params[:id])
      redirect_to tasks_path, notice: "編集しました"
    else
      render :edit
    end
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
