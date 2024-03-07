class TasksController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]

  def index
    @my_tasks = Task.where(user: current_user).where(match_id: params[:match_id])
    @buddy_tasks = Task.where(match_id: params[:match_id]).reject { |task| task.user == current_user}
  end

end
