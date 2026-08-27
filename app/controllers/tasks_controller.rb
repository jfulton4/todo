class TasksController < ApplicationController
  before_action :authenticate_user!

  def new
    @task = current_user.tasks.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task created successfully."
    else
      render :new
    end
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task updated successfully."
    else
      redirect_to tasks_path, alert: "Could not update task."
    end
  end

  def index
    @tasks = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    @task.destroy
    redirect_to tasks_path, notice: "Task deleted successfully."
  end

  private
    def task_params
      params.require(:task).permit(:name,:completed)
    end
end
