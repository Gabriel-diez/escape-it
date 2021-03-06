class GamesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_game, only: [:edit, :update, :destroy, :start, :reset]

  # GET /games
  # GET /games.json
  def index
    if params[:search]
      @games = current_user.games.search(params[:search]).order(started: :desc)
    else
      @games = current_user.games.all.order(started: :desc)
    end
  end

  # GET /games/new
  def new
    @game = current_user.games.new
  end

  # GET /games/1/edit
  def edit
  end

  def show
    render json: Game.find(params[:id]).next_instruction
  end

  # POST /games
  # POST /games.json
  def create
    @game = current_user.games.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to game_steps_path(game_id: @game.id), notice: 'La partie a bien été créée' }
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
        format.html { redirect_to games_path, notice: 'La partie a bien été éditée' }
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
    @game.reset
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'La partie a bien été supprimée' }
      format.json { head :no_content }
    end
  end

  def start
    if @game.started
      redirect_to games_path, notice: 'La partie est déjà en cours. Réinitialisé la pour la redemarrer'
    elsif @game.start
      redirect_to games_path, notice: 'La partie a bien été lancée'
    end
  end

  def reset
    if @game.reset
      redirect_to games_path, notice: 'La partie a bien été réinitialisée'
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
