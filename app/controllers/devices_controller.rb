class DevicesController < ApplicationController
  before_action :authenticate_user!, except: [:validate]
  before_action :set_resources
  before_action :set_device, except: [:validate, :index, :new, :get_sensors]

  def index
    @devices = @step.devices.all
  end

  def new
    @device = @step.devices.new
  end

  def edit
  end

  def sensors
    render json: Sensit.new(current_user).sensors(params[:device_id])
  end

  def validate
    @step.devices.find(params[:device_id]).update(is_ok: true) if @game.started
    render json: { game_started: @game.started }
  end

  def create
    @device = @step.devices.new(step_params)

    respond_to do |format|
      if @device.save
        format.html { redirect_to game_steps_path, notice: 'Sensit correctement créé.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(step_params)
        format.html { redirect_to game_steps_path, notice: 'Sensit mis à jour.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to game_steps_devices_path(game_id: @game.id, step_id: @step.id), notice: 'Sensit supprimé' }
      format.json { head :no_content }
    end
  end

  private

    def set_resources
      @game = Game.find(params[:game_id])
      @step = @game.steps.find(params[:step_id])
    end

    def set_device
      @device = @step.devices.find(params[:id]) unless params[:id].nil?
    end

    def step_params
      params.require(:device).permit(:sensor_id, :device_id, :value, :sensor_type)
    end
end
