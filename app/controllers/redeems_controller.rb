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

    customer_combs = @customer.customer_combs.includes(:combo)

    # Get redemption counts for each customer_comb
    @redeem_counts = Redeem.where(customer_comb_id: customer_combs.pluck(:id))
                           .group(:customer_comb_id)
                           .count
    puts @redeem_counts
    # Filter out fully redeemed combos
    @customer_combs = customer_combs.reject do |customer_comb|
      redeem_count = @redeem_counts[customer_comb.id] || 0
      redeem_count >= customer_comb.combo.count
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
      RedeemMailer.redeem_confirmation(@redeem).deliver_now
      redirect_to root_path, notice: "Redeem successful! Confirmation email sent."
    else
      puts "⚠️ Redeem Save Failed: #{@redeem.errors.full_messages}" # Log errors to console
      flash[:alert] = @redeem.errors.full_messages.to_sentence # Show error message
      redirect_to show_customer_combos_redeems_path(customer_id: params[:customer_id])
    end
  end

  def delete_combo
    customer_id = params[:customer_id]
    combo_id = params[:combo_id]

    customer_comb = CustomerComb.find_by(customer_id: customer_id, combo_id: combo_id)

    if customer_comb
      customer = customer_comb.customer
      combo = customer_comb.combo
      customer_comb.destroy

      ComboMailer.combo_deleted_notification(customer, combo).deliver_now

      redirect_to show_customer_combos_redeems_path(customer_id: customer_id), notice: "Combo Deleted for Customer! Email Sent."
    else
      redirect_to show_customer_combos_redeems_path(customer_id: customer_id), alert: "Combo not found!"
    end
  end
end
