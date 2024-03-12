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
                    .where(status: 'in progress')
    # @match = Match.find(params[:id]) >> did not work
  end

  def my_achievements
    @completed_goals = Goal.where(user: current_user, status: "completed")
    @canceled_goals = Goal.where(user: current_user, status: "canceled")
    all_matches = current_user.matches
    @matched_buddies_total = all_matches.map { |match| match.matched_goal.user }.uniq.count
    @sign_in_log = SignInLog.where(user: current_user)
    @last_seven_days = []
    for i in (0..30).to_a
      @last_seven_days << {
        date: "#{(Date.today-i).to_s}",
        signed_in: SignInLog.where(user: current_user, created_at: ((Date.today-i).beginning_of_day..(Date.today-i).end_of_day)).exists?
      }
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:category, :description)
  end

  # def match_params
    # params.require(:match).permit(:status, :matched_goal_id, :goal_id)
  # end

end
