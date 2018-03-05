class Api::V1::TasksController < Api::V1::BaseController
  def index
    render json: Task.all
  end

  def show
    respond_with task
  end

  def create
    @task = Task.new(task_params[:_json])

    if task.save
      render json: task
    else
      render json: { status: 'error', message: task.errors }, status: :not_acceptable
    end
  end

  def destroy
    respond_with task.destroy
  end

  def update
    respond_with task.update_attributes(task_params[:_json])
  end

  private

  def task
    @task ||= Task.find(task_params[:id])
  end

  def task_params
    params.permit(
      :format, :id, :text, :complete, :priority,
      _json: [:text, :complete, :priority]
    )
  end

  def record_not_found
    payload = { status: 'error', message: 'record not found' }
    respond_with payload, status: :not_found
  end
end
