require 'ostruct'

class Mailer < ActionMailer::Base
  default :from => "do-not-reply@getshrink.com"

  def notification(notification_id, title, project_token)
    @notification_id  = notification_id
    @title            = title
    @project          = Project.where(:token => project_token).first

    @project ||= OpenStruct.new(:name => "Shrink")
    
    mail :subject => "[#{@project.name}] #{title}"
  end
end
