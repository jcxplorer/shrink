Given /^I have a user with email "([^"]*)" and password "([^"]*)"$/ do |email, password|
  Factory :user, :email => email, :password => password
end

Given /^I have a user named "([^"]*)"$/ do |name|
  Factory :user, :name => name
end

Given /^another user named "([^"]*)"$/ do |name|
  Factory :user, :name => name
end

Then /^I should have a user with email "([^"]*)"$/ do |email|
  User.where(:email => email).count.should == 1
end
