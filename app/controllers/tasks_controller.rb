class TasksController < ApplicationController
  # skip_before_action :authenticate_user!, only: [:home]

  def index
    @match = Match.find(params[:match_id])
    @my_tasks = Task.where(user: current_user).where(match_id: params[:match_id])
    @buddy_tasks = Task.where(match_id: params[:match_id]).reject { |task| task.user == current_user }
    @task = Task.new
  end

  def create
    @match = Match.find(params[:match_id]) # Find the match associated with the task
    @task = Task.new(task_params)
    @task.match = @match
    @task.user = current_user
    if @task.save
      redirect_to match_path(@match)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:description, :status)
  end
end
