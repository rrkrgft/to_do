class LabelsController < ApplicationController
  def new
    @label = Label.new
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to 
    else
      render :new, notice: "登録エラーです"
    end
  end

  def index
    @label = Lavel.all
  end

  def edit
    set_label
  end

  def update
    set_label
    if @label.update
      redirect_to 
    else
      render :edit, notice: "編集エラーです"
    end
  end

  def destroy
    set_label
    @label.destroy
    redirect_to 
  end

  private
  def label_params
    params.require(:label).permit(:labelname)
  end

  def set_label
    @label = Label.find(params[:id])
  end
end
