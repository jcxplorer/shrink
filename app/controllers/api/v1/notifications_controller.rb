class Api::V1::NotificationsController < ActionController::Base
  def create
    token   = params[:notification][:token]
    project = Project.where(:token => token)

    if project.any?
      Notification.save(params[:notification])
      head 200
    else
      head 403
    end
  end
end
