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
    @my_tasks = Task.where(user: current_user).where(match: @match).order(created_at: :asc)
    @buddy_tasks = Task.where(match: @match).where.not(user: current_user).order(created_at: :asc)
    @task = Task.new

    # Calculate progress percentage - current user
    my_total_tasks = @my_tasks.count
    my_completed_tasks = @my_tasks.where(status: true).nil? ? 0 : @my_tasks.where(status: true).count
    @my_progress = my_total_tasks > 0 ? (my_completed_tasks.to_f / my_total_tasks) * 100 : 0

    # Calculate progress percentage - buddy of current user
    buddy_total_tasks = @buddy_tasks.count
    buddy_completed_tasks = @buddy_tasks.where(status: true).nil? ? 0 : @buddy_tasks.where(status: true).count
    @buddy_progress = buddy_total_tasks > 0 ? (buddy_completed_tasks.to_f / buddy_total_tasks) * 100 : 0

    @chatroom = @match.chatroom
    @chat = Chatroom.new
  end

  def edit
    find_match
  end

  def update
    find_match
    # @match.update(match_params)
    redirect_to profile_path(current_user), notice: "Goal successfully created"

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
                                         .where(sub_category: clicked_goal_subcategory)
    goal_id_sampled_by_category = Goal.where(status: 'not started', matched: false)
                                      .where.not(user: current_user)
                                      .where(category: clicked_goal_category)

    matched_goal_id = goal_id_sampled_by_subcategory.empty? ? goal_id_sampled_by_category.sample.id : goal_id_sampled_by_subcategory.sample.id

    # create the match as we now goal and matched_goal
    @match = Match.new
    @match.goal = Goal.find(params[:match][:goal].to_i)
    @goal = @match.goal
    @match.matched_goal = Goal.find(matched_goal_id)

    # Create a new record in the matches table
    # Respond with appropriate JSON data
    respond_to do |format|
      if @match.save
        format.html {
          redirect_to profile_path, info: "Successfully matched, please go to dashboards!"
        }
        format.json
      else format.html {
        redirect_to profile_path, info: "Sorry no matches yet!"
      }
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
    params.require(:match).permit(:status, :cancel_reason)
  end

  def find_match
    @id = params[:id]
    @match = Match.find(params[:id])
  end
end
