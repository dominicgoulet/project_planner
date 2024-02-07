class TasksController < ApplicationController
  before_action :ensure_frame_response, only: [:new, :edit]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new(start_date: params[:date])
    if params[:blocked_by].present?
      @task.task_relations.build(blocked_by_id: params[:blocked_by])
    end
    @task.task_relations.build
    @task.task_materials.build
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      @task.update_calculations!
      # redirect_to tasks_url, notice: 'Task was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task.task_relations.build
    @task.task_materials.build
  end

  def update
    if @task.update(task_params)
      @task.update_calculations!
      # redirect_to tasks_url, notice: 'Task was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(
      :supplier_id, :name, :budget, :cost, :estimated_time, :time_elapsed, :start_date, :started_on, :completed_on,
      task_relations_attributes: [:id, :blocked_by_id, :_destroy],
      task_materials_attributes: [:id, :material_id, :quantity, :unit_price, :_destroy]
    )
  end
end
