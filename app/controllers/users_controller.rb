class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "ユーザー登録しました"
    else
      render :new
    end
  end

  def index
    @user = User.all
  end

  def show
    set_user
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def edit
  end

  

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
