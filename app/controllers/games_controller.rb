class GamesController < ApplicationController

  def index
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new()
  end

  private

  def game_params
    params.require(:game).permit(:title, :description, :creator)
  end

end
