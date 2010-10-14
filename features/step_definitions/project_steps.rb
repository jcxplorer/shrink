Then /^I should have a project named "([^"]*)"$/ do |name|
  Project.where(:name => name).should_not be_empty
end

Then /^the user "([^"]*)" associated with it$/ do |name|
  user = User.where(:name => name).first
  project.users.should include(user)
end

Then /^the user "([^"]*)" should not be a part of the project$/ do |name|
  user = User.where(:name => name).first
  project.users.should_not include(user)
end

Given /^I have a project named "([^"]*)"$/ do |name|
  @project = Factory(:project, :name => name)
end

Given /^I have a project$/ do
  @project = Factory(:project)
end

Given /^I have a user named "([^"]*)" associated with it$/ do |name|
  user = Factory(:user, :name => name)
  project.users << user
end

Then /^I should have no project named "([^"]*)"$/ do |name|
  Project.where(:name => name).should be_empty
end

Then /^the project "([^"]*)" should have no users$/ do |name|
  Project.where(:name => name).first.users.should be_empty
end

Then /^I should see the API token$/ do
  token = Project.last.token
  page.should have_content(token)
end

def project
  @project || Project.last
end
