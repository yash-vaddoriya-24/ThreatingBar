class CombosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_combo, only: %i[ edit update destroy]
  def index
    @combos = Combo.all
    @combo = Combo.new
  end

  def assign_customer
    @action_type = params[:type]
    search_params = params.fetch(:q, {}).permit(:name_or_phone_no_or_email_cont)
    @q = Customer.ransack(search_params)
    @customers = @q.result(distinct: true)
  end


  def select_combos
    @combos = Combo.all
    @customer = Customer.find(params[:customer_id])# Fetch only unassigned combos
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
    @combo.assign_attributes(combo_params)
    calculate_total_price(@combo)

    if @combo.save
      flash[:notice] = "Combo updated successfully."
      redirect_to combos_path
    else
      flash[:alert] = @combo.errors.full_messages.to_sentence
      redirect_to edit_combo_path(@combo), status: :unprocessable_entity
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
      flash.now[:notice] = "Combo Assign successfully."
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

  def calculate_total_price(combo)
    service = Service.find(combo.service_id)
    combo.total_price = combo.count * service.price - combo.discount
    combo.save
  end
end
