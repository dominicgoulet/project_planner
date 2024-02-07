class ExpensesController < ApplicationController
  before_action :ensure_frame_response, only: [:new, :edit]
  before_action :set_expense, only: [:edit, :update, :destroy]

  def index
    @expenses = Expense.all.order(date: :desc)
  end

  def new
    @expense = Expense.new(date: Date.today, payment_method_id: Expense.last.payment_method_id)
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      # redirect_to expenses_url, notice: 'Expense was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @expense.update(expense_params)
      # redirect_to expenses_url, notice: 'Expense was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :step_id, :supplier_id, :description, :payment_method_id, :amount)
  end
end
