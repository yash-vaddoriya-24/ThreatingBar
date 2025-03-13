class CombosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_combo, only: %i[ edit update destroy]
  before_action :new_combo, only: %i[ index new ]
  def index
    @combos = Combo.all
  end

  def new
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
    actual_amount = service.price * combo.count
    discount_amount = actual_amount * (combo.discount.to_f / 100)
    combo.total_price = actual_amount - discount_amount
  end
end
