class Api::V1::PlayerController < ApplicationController

  def create
    player = Player.new(params.require(:player).permit(:name, :post, :team_id))
    team = Team.find_by(id:player.team_id)

    if team.nil? and player.team_id != nil
      render json: {error: 'Team introuvable'}, status: :not_found
    elsif player.save
      render json: {player: player}, status: :created
    else
      render json: {errors: player.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    players = Player.all

    render json:{player:players}
  end

  def show
    player = Player.find_by(id:params[:id])

    if player
      render json: {player: player}
    else
      render json: {message: "Player doesn't exist"}, status: 400
    end
  end

  def change_team
    param = [params[:name], params.dig(:team, :name)]
    player = Player.find_by(name: param[0])
    new_team = Team.find_by(name: param[1])

    if !player
      render json: {message: "Player doesn't exist"}, status: 400
    elsif !new_team && param[1] != nil
      render json: {error: 'Team introuvable'}, status: :not_found
    else
      if new_team.nil?
        player.update(team_id: nil)
      else
        player.update(team_id: new_team::id)
      end
      render json: {message: "Team corectly changed"}, status: 200
    end
  end
end
