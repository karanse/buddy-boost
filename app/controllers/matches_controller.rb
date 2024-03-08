class MatchesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @matches = Match.joins(:goal)
  #                    .where('goals.user_id = ?', current_user.id)
  # end

  def index
    # matches only belongs to the current logged in user
    @matches = Match.where('goal_id IN (?) OR matched_goal_id IN (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id))
  end

  def show
    @match = Match.find(params[:id])
  end

  def edit
    find_match()
  end

  def update
    find_match()
    @match.update(match_params)
    redirect_to profile_path(current_user)
  end

  private

  def match_params
    params.require(:match).permit(:status)
  end

  def find_match
    id = params[:id]
    @match = Match.find(params[:id])
  end

end
