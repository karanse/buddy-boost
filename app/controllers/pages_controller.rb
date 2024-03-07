class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
  end

  def legal
  end

  def profile
    @goals = Goal.where(user: current_user)
    @goal = Goal.new
  end

  private

  def goal_params
    params.require(:goal).permit(:category, :description)
  end
  
end
