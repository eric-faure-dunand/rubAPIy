class Api::V1::TeamsController < ApplicationController
  def create
    team = Team.new(params.require(:team).permit(:name, :city))

    if team.save
      render json: {team: team}, status: :created
    else
      render json: {errors: team.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def index
    teams = Team.all

    render json:{teams:teams}
  end

  def show
    team = Team.find_by(id:params[:id])

    if team
      render json: {team:team}
    else
      render json: {message: "Team doesn't exist"}, status: 400
    end
  end

end
