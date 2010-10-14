class ProjectsController < ApplicationController
  respond_to :html
  before_filter :current_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    @project.save and flash[:notice] = "Project created successfully."
    respond_with @project, :location => [@project, :notifications]
  end

  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:notice] = "Project updated successfully."
    end
    respond_with @project, :location => [@project, :notifications]
  end

  def destroy
    if @project.destroy
      flash[:notice] = "Project removed successfully."
    else
      flash[:error] = "Something went wrong and the project was not destroyed. Please try again."
    end
    respond_with @project
  end

  protected

  def current_project
    @project ||= Project.find(params[:id])
  end
end
