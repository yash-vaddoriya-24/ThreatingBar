class CombosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_combo, only: %i[ edit update destroy]
  before_action :new_combo, only: %i[ index new ]
  def index
    @combos = Combo.all
  end

  def new
  end

  def assign_customer
    @customers = Customer.all  # Fetch all customers
    @combo_ids = params[:combo_ids] || []   # Get selected combo IDs
  end

  def choose_customer
    if params[:combo_ids].present?
      session[:selected_combos] = params[:combo_ids] # Store in session
      redirect_to assign_customer_path
    else
      flash[:alert] = "Please select at least one combo."
      redirect_to select_combos_path
    end
  end

  def select_combos
    @combos = Combo.all # Fetch only unassigned combos
  end
  def create
    @combo = Combo.new(combo_params)
    calculate_total_price(@combo) # Auto-calculate total price

    if @combo.save
      flash.now[:notice] = "Combo created successfully."
      redirect_to combos_path
    else
      flash.now[:alert] = @combo.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @combo.assign_attributes(combo_params)  # Assign new attributes first
    calculate_total_price(@combo)  # Recalculate total price

    if @combo.save  # Save the updated combo
      flash.now[:notice] = "Combo updated successfully."
      redirect_to combos_path
    else
      flash.now[:alert] = @combo.errors.full_messages.to_sentence
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @combo.destroy
    redirect_to combos_path, notice: "Combo deleted successfully."
  end

  def assign
    customer_id = params[:customer_id]
    combo_ids = params[:combo_ids] || []

    if customer_id.blank? || combo_ids.empty?
      redirect_to assign_customer_combos_path, alert: "Customer and combos must be selected."
      return
    end

    combo_ids.each do |combo_id|
      CustomerComb.create(customer_id: customer_id, combo_id: combo_id)
      # flash.now[:notice] = "Combo Assign successfully."
    end

    redirect_to root_path, notice: "Combos assigned successfully."
  end


  private
  def set_combo
    @combo = Combo.find_by(id: params[:id])
    unless @combo
      redirect_to combos_path, alert: "Combo not found."
    end
  end

  def combo_params
    params.require(:combo).permit(:service_id, :count, :discount, :user_id)
  end

  def new_combo
    @combo = Combo.new
  end

  def calculate_total_price(combo)
    service = Service.find(combo.service_id)
    # actual_amount = service.price * combo.count
    # discount_amount = actual_amount * (combo.discount.to_f / 100)
    combo.total_price = service.price - discount_amount
  end

end
