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
    @tasks = current_user.tasks.search_by_title(params[:search]).search_by_status(params[:select]).search_by_labels(params[:select2])
    #if (params[:search] == "" || params[:search] == nil) && (params[:select] == "" || params[:select] == nil ) && (params[:select2] == "" || params[:select2] == nil)
    if params[:sort_expired]
      @tasks = @tasks.order("deadline DESC")
    elsif params[:sort_priority]
      @tasks = @tasks.order("priority DESC")
    else
      @tasks = @tasks.order("created_at DESC")
    end
    #else
      #@tasks = Task.looks(params[:search]).looks2(params[:select]).looks3(params[:select2]).where(user_id: current_user.id)
    #end
    @tasks = @tasks.page(params[:page]).per(5)
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
    params.require(:task).permit(:title, :content, :deadline, :status, :priority, label_ids: [] )
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def user_check
    redirect_to tasks_path unless @task.user.id == current_user.id
  end
end
