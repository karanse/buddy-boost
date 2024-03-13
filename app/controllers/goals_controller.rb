class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = Goal.where(user: current_user)
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to profile_path, info: "Goal successfully created! Please go to your goals!"

    else
      # render :new, status: :unprocessable_entity
    end
  end

  def edit
    find_goal()
  end

  def update
    find_goal()
    @goal.update(goal_params)
    redirect_to profile_path
  end

  def destroy
    find_goal()
    @goal.destroy
    redirect_to profile_path, status: :see_other
  end

private

  def find_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:category, :sub_category, :description, :deadline, :offline, :online)
  end

end
