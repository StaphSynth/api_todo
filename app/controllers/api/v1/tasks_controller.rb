class Api::V1::TasksController < Api::V1::BaseController
  def index
    respond_with Task.all
  end

  def show
    respond_with task
  end

  def create
    render json: Task.create(task_params[:_json]).to_json
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
    params.permit(:id, _json: [:text, :complete, :priority])
  end

  def record_not_found
    payload = { status: 404, message: 'record not found' }
    respond_with payload, status: :not_found
  end
end
