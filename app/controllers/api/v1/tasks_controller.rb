class Api::V1::TasksController < Api::V1::BaseController
  before_action :set_task, only: [:update, :destroy]

  def index
    render json: current_owner.tasks
  end

  def create
    task = current_owner.tasks.new(task_params)

    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_task
    @task = current_owner.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :completed)
  end
end
