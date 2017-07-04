class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: [:edit, :update, :destroy, :start, :reset]

  # GET /games
  # GET /games.json
  def index
    @games = current_user.games.all
  end

  # GET /games/new
  def new
    @game = current_user.games.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to games_path, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: games_path }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to games_path, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: games_path }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def start
    @game.start
  end

  def reset
    if @game.reset
      render :show, status: :ok, location: @game
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = current_user.games.find(params[:id]||params[:game_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params.require(:game).permit(:name)
    end
end
