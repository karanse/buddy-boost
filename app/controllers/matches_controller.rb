class MatchesController < ApplicationController
  before_action :authenticate_user!

  # def index
  #   @matches = Match.joins(:goal)
  #                    .where('goals.user_id = ?', current_user.id)
  # end

  def index
    @matches = Match.where('goal_id IN (?) OR matched_goal_id IN (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id))
  end

end
