class GoalsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = Goal.where(user: current_user)
    @goal = Goal.new
  end

  # def show
  #   @goal = Goal.find(params[:id])
  # end


  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      redirect_to profile_path
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def goal_params
    params.require(:goal).permit(:category, :description, :deadline)
  end

end
