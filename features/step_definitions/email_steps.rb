Then /^I should have an email$/ do
  ActionMailer::Base.deliveries.count.should == 1
end

Then /^the email subject should be "([^"]*)"$/ do |subject|
  email.subject.should == subject
end

Then /^the email body should contain a link to the notification$/ do
  project       = Project.last
  notification  = project.notifications.last

  email.body.should include(project_notification_url(project, notification, :host => host))
end

def email
  ActionMailer::Base.deliveries.last
end

def host
  ActionMailer::Base.default_url_options[:host]
end
