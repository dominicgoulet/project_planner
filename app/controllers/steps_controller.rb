class StepsController < ApplicationController
  before_action :set_step, only: [:edit, :update, :destroy]

  def index
    @steps = Step.all
  end

  def new
    @step = Step.new
  end

  def create
    @step = Step.new(step_params)

    if @step.save
      redirect_to steps_url, notice: 'Step was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @step.update(step_params)
      redirect_to steps_url, notice: 'Step was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @step.destroy
      redirect_to steps_url, notice: 'Step was successfully destroyed.'
    else
      redirect_to steps_url, notice: 'Step was not destroyed.'
    end
  end

  private

  def set_step
    @step = Step.find(params[:id])
  end

  def step_params
    params.require(:step).permit(:name, :budget)
  end
end
