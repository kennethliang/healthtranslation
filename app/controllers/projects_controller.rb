class ProjectsController < ApplicationController

  def new
    @project = Project.create
  end

  def update
    @project = Project.new(project_params)
    @project.status = :created
    if @project.save
      flash[:notice] = 'Project created successful.'
    else
      flash[:error] = 'Failed to create project.'
    end
  end

  def done
    @project.find(params[:project_id])
  end

  private

  def project_params
    params.require(:project).permit(:name, :project_type, :from_language_id, :to_language_id)
  end

end
