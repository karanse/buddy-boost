class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :legal]

  def home
  end

  def legal
  end

  def profile
    # To show goals of the logged in users on goals tab - profile
    @goals = Goal.where(user: current_user)
    @goal = Goal.new

    # To show in-progress matches on dashboards tab - profile
    @matches_current = Match.where('(goal_id IN (?) OR matched_goal_id IN (?)) AND status = (?)',
                                   current_user.goals.pluck(:id),
                                   current_user.goals.pluck(:id), 'in progress')

    # New match
    @match = Match.new

    # To show goal statistics on achiements tab - profile
    @completed_goals = Goal.where(user: current_user, status: 'completed')
    @canceled_goals = current_user.matches.where(status: 'cancelled').uniq
    # Match.where(user: current_user, status: 'cancelled')

    # To show all the unique buddies of current user from completed & in progress matches

    # Fetch matches directly from the database
    matches_all = current_user.matches.where(status: ['in progress', 'completed']).includes(:goal, :matched_goal)

    # Extract goal IDs and matched goal IDs into arrays
    goal_ids = matches_all.pluck(:goal_id, :matched_goal_id).flatten.uniq

    # Fetch goals excluding the current user's goals
    buddy_goals = Goal.where(id: goal_ids).where.not(user_id: current_user.id)

    # Fetch users associated with buddy goals
    @matched_buddies_total = User.where(id: buddy_goals.pluck(:user_id)).uniq.count

    @sign_in_log = SignInLog.where(user: current_user)
    @last_seven_days = []
    (0..29).to_a.each do |i|
      @last_seven_days << {
        date: (Date.today - i).to_s,
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
