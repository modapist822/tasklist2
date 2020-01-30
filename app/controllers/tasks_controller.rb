class TasksController < ApplicationController
  
  before_action :set_message, only:[:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    if logged_in?
      @task = current_user.tasks.build
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end  
  end

  def show
  end

  def new
    @tasks = Task.new
  end

  def create
    @tasks = current_user.tasks.build(task_params)

    if @tasks.save
      flash[:success] = 'Task が正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task が投稿されませんでした'
      render :root_url
    end
  end

  def edit
  end

  def update

    if @tasks.update(task_params)
      flash[:success] = 'タスク は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'タスク は更新されませんでした'
      render :edit
    end
    
  end

  def destroy
    @tasks.destroy

    flash[:success] = 'タスク は正常に削除されました'
    redirect_to tasks_url
  end

  private
  
  def set_message
    @tasks = Task.find(params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end

end