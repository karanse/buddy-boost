class GoalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def index
    @goals = Goal.all
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = @user
    if @goal.save
      redirect_to goals_path(@goal)
    else
      render :new, status: :unprocessable_entity
    end
  end

private

  def goal_params
    params.require(:goal).permit(:category, :description)
  end

end
