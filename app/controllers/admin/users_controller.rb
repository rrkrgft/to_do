class Admin::UsersController < ApplicationController
  before_action :admin_check

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "ユーザー登録しました"
    else
      render :new
    end
  end

  def index
    @user = User.all.includes(:tasks)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "編集しました"
    else
      render :edit, notice: '編集できません'
    end
  end

  def show
    set_user
  end

  def destroy
    set_user
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザーを削除しました"
    else
      redirect_to admin_users_path, notice: "ユーザーを削除出来ませんでした"
    end
  end

  private
  def admin_check
    redirect_to tasks_path, notice: "管理者以外はアクセスできません" unless current_user.admin 
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
