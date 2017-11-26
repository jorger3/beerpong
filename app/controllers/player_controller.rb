class PlayerController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
  	Player.all.each do |p|
  		p.update(wins: (Match.where(winner_one: p.id).count + Match.where(winner_two: p.id).count))
  	end
    @players = Player.all.order(wins: :desc)
  end
  def new
    @player = Player.new
  end
  def create
    @player = Player.new(name: params[:name])
    @player.update(user_id: current_user.id)

    if @player.save!
      flash[:success] = "Jugador agregado"
      BpLog.create(user_id: current_user.id, action: 'create', controller: 'player', data_id: @player.id)
      redirect_to new_player_path
    else
      render :new
    end
  end

end