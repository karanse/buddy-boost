class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    # matches only belongs to the current logged in user
    @matches = Match.where('goal_id IN (?) OR matched_goal_id IN (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id))
                    .where(status: 'in progress')
  end

  def show
    @match = Match.find(params[:id])
     # for buddy dashboard tasks
    @my_tasks = Task.where(user: current_user).where(match: @match)
    @buddy_tasks = Task.where(match: @match).reject { |task| task.user == current_user }
    @task = Task.new
  end

  def edit
    find_match
  end

  def update
    find_match
    @match.update(match_params)
    redirect_to profile_path(current_user)
  end

  def create
    # Perform the matching logic here
    # Get the goal category user clicked on frontend w/ params[:match][:goal]
    clicked_goal_category = Goal.find(params[:match][:goal].to_i).category

    # Find the first unmtached goal with the same category to make the match
    matched_goal_id = Goal.where(status: 'not started')
                          .where.not(user: current_user)
                          .find_by(category: clicked_goal_category).id
    # create the match as we now goal and matched_goal
    @match = Match.new
    @match.goal = Goal.find(params[:match][:goal].to_i)
    @goal = @match.goal
    # @goal = @match.goal
    @match.matched_goal = Goal.find(matched_goal_id)
    # Create a new record in the matches table
    # Respond with appropriate JSON data

    respond_to do |format|
      if @match.save
        format.html {redirect_to profile_path}
        format.json
      # else
      #   format.html {redirect_to profile_path}
      #   format.json
      end
    end



  end

  private

  def match_params
    params.require(:match).permit(:status)
  end

  def find_match
    @id = params[:id]
    @match = Match.find(params[:id])
  end
end
