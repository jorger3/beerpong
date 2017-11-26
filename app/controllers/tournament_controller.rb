class TournamentController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @tournaments = Tournament.all


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
      @tournament = Tournament.new(name: params[:tournament][:name], location: params[:tournament][:location], season: 0, finished: false, user_id: current_user.id)
    else
      season = same_location.last.season+1
      @tournament = Tournament.new(name: params[:tournament][:name], location: params[:tournament][:location], season: season, finished: false, user_id: current_user.id)
    end
    

    if @tournament.save!
      flash[:success] = "Torneo Creado"
      BpLog.create(user_id: current_user.id, action: 'create', controller: 'tournament', data_id: @tournament.id)
      redirect_to tournament_path(@tournament.id)
    else
      render :new
    end
  end

  def show

    
    @tournament = Tournament.where(id: params[:id]).first

    @players = []
    @matches = Match.where(tournament_id: params[:id])

    @matches.each do |match|
      match.players.each do |player|
        if !(@players.include? player)
          @players << player
        end
      end
    end
    #puts @players

    

    if @players.nil?
      @winner = []
    else
      @winner = @players.sort_by{ |t| -t.wins }
    end
  end

  def finished
    tournament = Tournament.find(params[:id])
    if tournament.update!(finished: params[:finished])
      if params[:finished] == true
        flash[:success] = "Torneo terminado"
        BpLog.create(user_id: current_user.id, action: 'finished', controller: 'tournament', data_id: tournament.id)
      else
        flash[:danger] = "Torneo NO terminado"
        BpLog.create(user_id: current_user.id, action: 'unfinished', controller: 'tournament', data_id: tournament.id)
      end
      redirect_to tournament_path(params[:id])
    else
      render :new
    end

  end

   private
    def update_wins(id)
      @players.each do |p|
        p.wins(wins: (Match.where(winner_one: p.id, tournament_id: id).count + Match.where(winner_two: p.id, tournament_id: id).count))
      end
      return @players
    end

  #   def set_tournament
  #     @tournament = Tournament.find(params[:id])
  #   end
end
