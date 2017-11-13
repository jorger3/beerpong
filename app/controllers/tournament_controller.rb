class TournamentController < ApplicationController
  def index
    @tournaments = Tournament.all

    Player.all.each do |p|
      p.update(wins: (Match.where(winner_one: p.id).count + Match.where(winner_two: p.id).count))
    end


    @winner = Player.all.order(wins: :desc).first

    if @winner.nil?
      @winner = "N/A"
    else
      @winner = @winner.name
    end
  end

  def new
    @tournament = Tournament.new
  end
  def create
    same_location = Tournament.where(location: params[:tournament][:location])
    if same_location.first.nil?
      @tournament = Tournament.new(name: params[:tournament][:name], location: params[:tournament][:location], season: 0)
    else
      season = same_location.last.season+1
      @tournament = Tournament.new(name: params[:tournament][:name], location: params[:tournament][:location], season: season)
    end

    if @tournament.save!
      flash[:success] = "Torneo Creado"
      redirect_to new_tournament_path
    else
      render :new
    end
  end

  def show

    update_wins()
    @tournament = Tournament.where(id: params[:id]).first
    @matches = Match.where(tournament_id: params[:id])
    #@players = Player.all

    @players = Match.where(tournament_id: params[:id]).first.players

  end

   private
    def update_wins
      Player.all.each do |p|
        p.update(wins: (Match.where(winner_one: p.id).count + Match.where(winner_two: p.id).count))
      end
    end

  #   def set_tournament
  #     @tournament = Tournament.find(params[:id])
  #   end
end
