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
    @matches_current = Match.where('(goal_id IN (?) OR matched_goal_id IN (?)) AND status = (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id),'in progress')
                    # .where(status: 'in progress')
    @match = Match.new

    @completed_goals = Goal.where(user: current_user, status: "completed")
    @canceled_goals = Goal.where(user: current_user, status: "cancelled")

    # all_goals = current_user.goals.where(status: "in progress", matched: true)
    # @matched_buddies_total = all_goals.map { |goal| goal.match.matched_goal.user}.uniq.count
    @matches_all = current_user.matches
    @goal_ids = @matches_all.map { |match| match.goal_id } + @matches_all.map { |match| match.matched_goal_id }
    @buddy_goals = @goal_ids.map { |id| Goal.find(id) }.reject { |goal| goal.user == current_user }
    @matched_buddies_total     = @buddy_goals.map { |goal| goal.user }.uniq.count

    @sign_in_log = SignInLog.where(user: current_user)
    @last_seven_days = []
    for i in (0..30).to_a
      @last_seven_days << {
        date: "#{(Date.today-i).to_s}",
        signed_in: SignInLog.where(user: current_user, created_at: ((Date.today-i).beginning_of_day..(Date.today-i).end_of_day)).exists?
      }
    end
  end

  def match
  end

  private

  def goal_params
    params.require(:goal).permit(:category, :description)
  end

  # def match_params
    # params.require(:match).permit(:status, :matched_goal_id, :goal_id)
  # end

end
