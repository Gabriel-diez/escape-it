class StepsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game
  before_action :set_step, except: [:index, :new, :create]

  # GET /steps
  # GET /steps.json
  def index
    @steps = @game.steps.all
  end

  # GET /steps/1
  # GET /steps/1.json
  def show
  end

  # GET /steps/new
  def new
    @step = @game.steps.new
  end

  # GET /steps/1/edit
  def edit
  end

  # POST /steps
  # POST /steps.json
  def create
    @step = @game.steps.new(step_params)

    respond_to do |format|
      if @step.save
        format.html { redirect_to game_step_devices_path(@game, @step), notice: 'Step was successfully created.' }
        format.json { render :show, status: :created, location: @step }
      else
        format.html { render :new }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /steps/1
  # PATCH/PUT /steps/1.json
  def update
    respond_to do |format|
      if @step.update(step_params)
        format.html { redirect_to game_steps_path, notice: 'Step was successfully updated.' }
        format.json { render :show, status: :ok, location: @step }
      else
        format.html { render :edit }
        format.json { render json: @step.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /steps/1
  # DELETE /steps/1.json
  def destroy
    @step.devices.each do |device|
      Sensit.new(current_user).delete_notification(device) if !device.notification_id.nil?
    end
    @step.destroy
    respond_to do |format|
      format.html { redirect_to games_path, notice: 'Step was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_game
      @game = current_user.games.find(params[:game_id])
    end

    def set_step
      @step = @game.steps.find(params[:id])
    end

    def step_params
      params.require(:step).permit(:name, :is_validated, :game_id, devices_attributes: [:sensor_id, :device_id])
    end
end
