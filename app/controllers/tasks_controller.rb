class TasksController < ApplicationController

def create
  @task = Task.new(task_params)
  @task.save
  redirect_to tasks_path
end

def update
  @task = Task.find(params[:id])
end

def index
  @tasks = Task.all
end

def show
  @task = Task.find(params[:id])
end

private
  def task_params
    params.require(:task).permit(:name,:completed)
  end
end
