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
    if (params[:search] == "" || params[:search] == nil) && (params[:select] == "" || params[:select] == nil )
      if params[:sort_expired]
        puts "test"
        @task = Task.order("deadline DESC")
      else
        puts "test2"
        @task = Task.order("created_at DESC")
      end
    else
      puts "test3"
      @task = Task.looks(params[:search], params[:select])
    end
  end

  def show
    set_task
  end

  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      redirect_to tasks_path, notice: "編集しました"
    else
      render :edit
    end
  end

  def destroy
    set_task
    @task.destroy
    redirect_to tasks_path, notice: "タスクを削除しました"
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :deadline, :status, :priority )
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
