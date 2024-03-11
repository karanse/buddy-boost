class MatchesController < ApplicationController
  before_action :authenticate_user!

  def index
    # matches only belongs to the current logged in user
    # @current_user_goal = Goal.where(user: current_user).where(match_id: params[:match_id])
    @matches = Match.where('goal_id IN (?) OR matched_goal_id IN (?)', current_user.goals.pluck(:id), current_user.goals.pluck(:id))
                    .where(status: 'in progress')
  end

  def show
    @match = Match.find(params[:id])
    @current_user_goal = Match.find(params[:id]).goal.user == current_user ? Match.find(params[:id]).goal : Match.find(params[:id]).matched_goal
     # for buddy dashboard tasks
    @my_tasks = Task.where(user: current_user).where(match: @match)
    @buddy_tasks = Task.where(match: @match).reject { |task| task.user == current_user }
    @task = Task.new
    @chatroom = @match.chatroom
    @chat = Chatroom.new
  end

  def edit
    find_match
  end

  def update
    find_match
    @match.update(match_params)
    redirect_to profile_path(current_user)

    # update match status based on user selection (completed or cancelled)
    @match.set_status(params[:match][:status], params[:match][:cancel_reason])

    # update goal status depending on match ending status
    if params[:match][:status] == 'completed'
      @match.goal.set_status('completed')
      @match.matched_goal.set_status('completed')
    else
      @match.goal.set_status('not started')
      @match.goal.set_unmatched
      @match.matched_goal.set_status('not started')
      @match.matched_goal.set_unmatched
    end
  end

  def create
    # Perform the matching logic here
    # Get the goal category user clicked on frontend w/ params[:match][:goal]
    clicked_goal_category = Goal.find(params[:match][:goal].to_i).category
    clicked_goal_subcategory = Goal.find(params[:match][:goal].to_i).sub_category

    # Find the first unmtached goal with the same category to make the match
    goal_id_sampled_by_subcategory = Goal.where(status: 'not started', matched: false)
                                         .where.not(user: current_user)
                                         .where(sub_category: clicked_goal_subcategory).sample.id
    goal_id_sampled_by_category = Goal.where(status: 'not started', matched: false)
                                      .where.not(user: current_user)
                                      .where(category: clicked_goal_category).sample.id

    matched_goal_id = goal_id_sampled_by_subcategory.nil? ? goal_id_sampled_by_category : goal_id_sampled_by_subcategory

    # create the match as we now goal and matched_goal
    @match = Match.new
    @match.goal = Goal.find(params[:match][:goal].to_i)
    @goal = @match.goal
    @match.matched_goal = Goal.find(matched_goal_id)

    # Create a new record in the matches table
    # Respond with appropriate JSON data
    respond_to do |format|
      if @match.save
        format.html { redirect_to profile_path }
        format.json
      end
    end
    # Update the goal status and matched=true after match is created!
    @match.goal.set_status('in progress')
    @match.goal.set_matched
    @match.matched_goal.set_status('in progress')
    @match.matched_goal.set_matched
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
