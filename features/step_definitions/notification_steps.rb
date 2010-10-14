Then /^I should have a notification for the project$/ do
  @project.notifications.count.should == 1
  @notification = @project.notifications.first
end

Then /^the notification should contain all the sample data$/ do
  @notification.id.should == "3e83a29e908ccef726743cd203da032b"
  @notification.title.should == "NameError: uninitialized constant Notification"

  @notification.groups.count.should == 3

  @notification.groups[0].name.should == "General"
  @notification.groups[0].display.should == "list"
  @notification.groups[0].attributes.count.should == 2
  @notification.groups[0].attributes[0].key.should == "Location"
  @notification.groups[0].attributes[0].value.should == "posts_controller.rb:24"
  @notification.groups[0].attributes[1].key.should == "Path"
  @notification.groups[0].attributes[1].value.should == "/posts/introducing-shrink"

  @notification.groups[1].name.should == "Backtrace"
  @notification.groups[1].display.should == "text"
  @notification.groups[1].text.should == "/srv/getshrink/app/controllers/posts_controller.rb:24:in `show'"

  @notification.groups[2].name.should == "Variables"
  @notification.groups[2].display.should == "table"
  @notification.groups[2].attributes.count.should == 1
  @notification.groups[2].attributes[0].key.should == "@post"
  @notification.groups[2].attributes[0].value.should == '#<Post id: 1, title: "Introducing Shrink">'
end

