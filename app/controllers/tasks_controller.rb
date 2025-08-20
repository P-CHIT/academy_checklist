class TasksController < ApplicationController
  before_action :set_task, only: %i[ destroy toggle ]

  # GET /tasks or /tasks.json
  def index
    @tasks = Task.all.order(created_at: :desc)
    @task = Task.new
  end

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)
    @task.status = false

    respond_to do |format|
      if @task.save
        format.html { redirect_to root_path, notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
      @tasks = Task.all.order(created_at: :desc)
      @task = Task.new
      flash.now[:alert] = "Title must not be null."
      format.html { render :index, status: :unprocessable_entity }
      format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def toggle
    @task.update!(status: !@task.status)
    redirect_to root_path
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy!

    respond_to do |format|
      format.html { redirect_to root_path, alert: "Task was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def brag
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.expect(task: [ :title, :status ])
    end
end
