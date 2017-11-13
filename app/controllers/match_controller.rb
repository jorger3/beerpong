class MatchController < ApplicationController
  def new
    @match = Match.new
    @players = Player.all
    @matches = Match.all
    @tournaments = Tournament.all


  end

  def index
    @matches = Match.all
    @tournaments = Tournament.all

    # @tour = @matches.first.players.name

    # puts @tour

  end

  def create
    @players = Player.all
    @tournaments = Tournament.all

    @player_one = Player.where(id: params[:player_one]).first
    @player_two = Player.where(id: params[:player_two]).first
    @player_three = Player.where(id: params[:player_three]).first
    @player_four = Player.where(id: params[:player_four]).first
    @tournament = Tournament.where(id: params[:tournament]).first
    @winner_one = ""
    @winner_two = ""

    @match = Match.new(match_params)
    @match.update(tournament_id: @tournament.id)
    @match.players << @player_one
    @match.players << @player_two
    @match.players << @player_three
    @match.players << @player_four

    if params[:match][:winner_one].to_i == 0
        @match.update(winner_one: @player_one.id)
        @match.update(winner_two: @player_two.id)
        @match.update(loser_one: @player_three.id)
        @match.update(loser_two: @player_four.id)
    elsif params[:match][:winner_one].to_i == 1
        @match.update(winner_one: @player_three.id)
        @match.update(winner_two: @player_four.id)
        @match.update(loser_one: @player_one.id)
        @match.update(loser_two: @player_two.id)
    end

    if @match.save
      flash[:success] = "Partido agregado"
      redirect_to new_match_path
    else
      render :new
    end
  end

  private
    def match_params
      params.require(:match).permit(:winner_one, :tournament, players: [:id, :name])
    end
end
