class PaymentMethodsController < ApplicationController
  before_action :set_payment_method, only: [:edit, :update, :destroy]

  def index
    @payment_methods = PaymentMethod.all
  end

  def new
    @payment_method = PaymentMethod.new
  end

  def create
    @payment_method = PaymentMethod.new(payment_method_params)

    if @payment_method.save
      redirect_to payment_methods_url, notice: 'Payment Method was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @payment_method.update(payment_method_params)
      redirect_to payment_methods_url, notice: 'Payment Method was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @payment_method.destroy
      redirect_to payment_methods_url, notice: 'Payment Method was successfully destroyed.'
    else
      redirect_to payment_methods_url, notice: 'Payment Method was not destroyed.'
    end
  end

  private

  def set_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def payment_method_params
    params.require(:payment_method).permit(:name, :budget)
  end
end
