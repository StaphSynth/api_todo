class Api::V1::TasksController < Api::V1::BaseController
  def index
    render json: Task.all
  end

  def show
    render json: task
  end

  def create
    @task = Task.new(task_params[:_json])

    if task.save
      render json: task
    else
      handle_mutating_errors
    end
  end

  def destroy
    if task.destroy
      render json: { status: 'success' }
    else
      handle_mutating_errors
    end
  end

  def update
    if task.update_attributes(task_params)
      render json: { status: 'success' }
    else
      handle_mutating_errors
    end
  end

  private

  def task
    @task ||= Task.find(task_params[:id])
  end

  def task_params
    params.permit(
      :id, :text, :complete, :priority,
      _json: [:text, :complete, :priority]
    )
  end

  def error_payload
    {}.tap do |hash|
      hash[:status] = 'error'
      hash[:message] = task.errors if task.errors.any?
    end
  end

  def handle_mutating_errors
    status = task.errors.any? ? :not_acceptable : :internal_server_error
    render json: error_payload, status: status
  end
end
