class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [ :edit, :update, :destroy ]
  def index
    @services = Service.all
    @service = Service.new
  end

  def show
    redirect_to services_path
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to services_path, notice: "Service created successfully."
    else
      puts "⚠️ Service Save Failed: #{@service.errors.full_messages}" # Debugging
      flash[:alert] = @service.errors.full_messages.to_sentence
      render :index, status: :unprocessable_entity
    end
  end


  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to services_path, notice: "Service was successfully updated."
    else
      render :edit, status: :unprocessable_entity, notice: @service.errors.full_messages.to_sentence
    end
  end

  def destroy
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_path, notice: "Service was successfully deleted." }
    end
  end


  private
  def service_params
    params.require(:service).permit(:name, :price, :category)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
