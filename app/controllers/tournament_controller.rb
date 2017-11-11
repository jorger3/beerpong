class TournamentController < ApplicationController
  def index
    @tournaments = Tournament.all

    Player.all.each do |p|
      p.update(points: (Match.where(winner_one: p.id).count + Match.where(winner_two: p.id).count))
    end
    @winner = Player.all.order(points: :desc).first.name

  end
  def new
    @tournament = Tournament.new
  end
  def create
    @tournament = Tournament.new(name: params[:tournament][:name], location: params[:tournament][:location], season: params[:tournament][:season])

    if @tournament.save!
      flash[:success] = "Torneo Creado"
      redirect_to new_tournament_path
    else
      render :new
    end
  end

  def show

    @tournament = Tournament.where(id: params[:id]).first
    @players = Player.all
    @matches = Match.where(tournament_id: params[:id])
    ranking = []

    @players.each do |p|
 		ranking << Match.where(tournament_id: @tournament.id).where(winner_one: p.id).count + Match.where(tournament_id: @tournament.id).where(winner_two: p.id).count
 	end
  end

  # private
  #   def params
  #     params.require(:tournament).permit(:name, :location, :seaso)
  #   end

  #   def set_tournament
  #     @tournament = Tournament.find(params[:id])
  #   end
end
