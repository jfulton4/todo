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
    # Did not check update with a conditional because update uses a checkbox
    # Good practice to use conditionals if validation fails
    @task.update(task_params)
    redirect_to tasks_path, notice: "Task updated successfully."
  end

  def index
    # did current_user.tasks.all, a remnant from User.tasks.all
    # When checking for this specific user, you only need current_user.tasks
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
