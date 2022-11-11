class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: %i[show edit update destroy]

  # GET projects/1/tasks
  def index
    @tasks = @project.tasks
  end

  # GET projects/1/tasks/1
  def show
    @tasks = Task.find(params[:id])
  end
 
  # GET projects/1/tasks/new
  def new
    @task = @project.tasks.new
  end

  # GET projects/1/tasks/1/edit
  def edit
    @tasks = Task.find(params[:id])
  end

  # POST projects/1/tasks
  def create
    @task = @project.tasks.new(task_params)

    if @task.save
      redirect_to([@task.project, @task], flash[:notice] = 'Task was successfully created.')
    else
      render :new
    end
  end

  # PUT projects/1/tasks/1
  def update
    if @task.update_attributes(task_params)
      redirect_to([@task.project, @task], flash[:notice] = 'Task was successfully created.')
    else
      render :edit
    end
  end

  # DELETE projects/1/tasks/1
  def destroy
    @tasks = Task.find(params[:id])
    @task.destroy
    flash[:notice] = 'Task destroyed.'
    redirect_to project_tasks_url(@project)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def task_params
    params.require(:task).permit(:name, :description, :status, :project)
  end
end
