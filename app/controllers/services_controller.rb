class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :new_service, only: [:new, :index]
  before_action :set_service, only: [:edit, :update, :destroy]
  def index
    @services = Service.all
    @service = Service.new
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to services_path, notice: "Service was successfully created."
    else
      render :index, status: :unprocessable_entity, notice: @service.errors.full_messages.to_sentence
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
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_path, notice: "Service was successfully deleted." }
    end
  end


  private
  def service_params
    params.require(:service).permit(:name, :price)
  end

  def new_service
    @service = Service.new
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
