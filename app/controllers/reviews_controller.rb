class ReviewsController < ApplicationController
  before_action :find_game

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.game_id = @game.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to game_path(@game)
    else
      render 'new'
    end
  end

  private

    def review_params
      params.require(:review).permit(:rating, :comment)
    end

    def find_game
      @game = Game.find(params[:game_id])
    end
end
