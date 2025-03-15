class RedeemsController < ApplicationController
  def select_customer
    @customers = Customer.all
  end

  def show_customer_combos
    if params[:customer_id].blank?
      redirect_to redeems_path, alert: "Customer ID is missing."
      return
    end

    @customer = Customer.find_by(id: params[:customer_id])

    if @customer.nil?
      redirect_to redeems_path, alert: "Customer not found."
      return
    end

    # Fetch all customer combos
    customer_combs = @customer.customer_combs.includes(:combo)

    # Filter out fully redeemed combos
    @customer_combs = customer_combs.reject do |customer_comb|
      redeem_count = Redeem.where(customer_comb_id: customer_comb.id).count
      redeem_count >= customer_comb.combo.count # Remove if redeemed count is >= combo count
    end
  end

  def redeem_combo
    customer_comb = CustomerComb.find_by(id: params[:customer_comb_id])

    if customer_comb.nil?
      redirect_to show_customer_combos_redeems_path(customer_id: params[:customer_id]), alert: "Invalid combo selection."
      return
    end

    @redeem = Redeem.new(customer_comb_id: customer_comb.id)

    if @redeem.save
      redirect_to root_path, notice: "Redeem successful!"
    else
      puts "⚠️ Redeem Save Failed: #{@redeem.errors.full_messages}" # Log errors to console
      flash[:alert] = @redeem.errors.full_messages.to_sentence # Show error message
      redirect_to show_customer_combos_redeems_path(customer_id: params[:customer_id])
    end
  end

  def delete_combo
    customer_id = params[:customer_id]
    combo_id = params[:combo_id]

    CustomerComb.find_by(customer_id: customer_id, combo_id: combo_id)&.destroy

    redirect_to show_customer_combos_redeems_path(customer_id: customer_id), notice: "Combo Deleted for Customer!"
  end
end
