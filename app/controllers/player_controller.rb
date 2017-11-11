class PlayerController < ApplicationController
  def index
  	Player.all.each do |p|
  		p.update(points: (Match.where(winner_one: p.id).count + Match.where(winner_two: p.id).count))
  	end
    @players = Player.all.order(wins: :desc)
  end
  def new
    @player = Player.new
  end
  def create
    @player = Player.new(player_params)

    if @player.save
      flash[:success] = "Jugador agregado"
      redirect_to new_player_path
    else
      render :new
    end
  end

  private
    def player_params
      params.require(:player).permit(:name)
    end

end