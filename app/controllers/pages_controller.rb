class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def legal
  end

  def profile
    # for goals overview
    @goals = Goal.where(user: current_user)
    @goal = Goal.new
    # for buddy dashboards overview - index
    @matches = Match.where('goal_id IN (?) OR matched_goal_id IN (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id))
    # @match = Match.find(params[:id]) >> did not work
  end

  private

  def goal_params
    params.require(:goal).permit(:category, :description)
  end

  # def match_params
  #   # params.require(:match).permit(:status, :matched_goal_id, :goal_id)
  # end

end
