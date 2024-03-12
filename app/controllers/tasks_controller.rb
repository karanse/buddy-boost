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
      render new, status: :unprocessable_entity
    end
  end

  def edit
    find_task()
  end

  def update
  #  raise
    @task = Task.find(params[:id].to_i)
    status = params[:task][:status] == "1"
    @task.update(status: status)
    redirect_to match_path(@task.match)

    # @task.update(status: params[:status])
    # if @task.update(params[:status])
    #   redirect_to match_path(@task.match)
    # else
    #   render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    # end

    # respond_to do |format|
    #   if  @task.update(params[:status])
    #     format.html { redirect_to match_path(@task.match) }
    #     format.json
    #   else
    #     format.html { render :edit }
    #     format.json { render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity }
    #   end
    # end
  end

  def destroy
    find_task()
    @task.destroy
    @match = Match.find(params[:match_id])
    redirect_to match_tasks_path(@match), status: :see_other
  end

  private
  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :status)
  end
end
