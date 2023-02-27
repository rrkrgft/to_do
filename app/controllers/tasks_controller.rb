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
  end

  def show
  end

  def edit
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority )
  end

end
