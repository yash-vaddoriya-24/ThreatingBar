class CustomersController < ApplicationController
  before_action :set_customer, only: [ :update, :destroy, :edit ]
  def index
    @customers = Customer.all
    @customer = Customer.new
  end

  def edit
    Rails.logger.debug "Customer Loaded: #{@customer.inspect}"
  end
  # Create a new customer
  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash.now[:notice] = "Customer created successfully."
      redirect_to customers_path
    else
      flash.now[:alert] = @customer.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end

  # Update an existing customer
  def update
    if @customer.update(customer_params)
      flash.now[:notice] = "customer Updated successfully."
      redirect_to customers_path
    else
      flash.now[:alert] = @customer.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy a customer
  def destroy
    @customer.destroy
    redirect_to customers_path, notice: "Customer deleted successfully."
  end

  private

  # Strong parameters to allow only permitted fields
  def customer_params
    params.require(:customer).permit(:name, :phone_no, :email)
  end

  # Find customer before update or destroy
  def set_customer
    @customer = Customer.find(params[:id])
  end
end
