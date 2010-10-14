class NotificationsController < ApplicationController
  before_filter :current_project

  def index
    @notifications = @project.notifications
  end

  def show
    @notification = @project.notifications(:id => params[:id]).first
  end

  protected

  def current_project
    @project = Project.find(params[:project_id])
  end
end
