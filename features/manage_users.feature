Feature: Manage users
  In order to let other people use Shrink
  as an existing user
  I want to create other user accounts

  Background:
    Given I am signed in
  
  Scenario: Creating a new user
    Given I am on the users page
    When I follow "Add a user"
    And I fill in "Name" with "Joe"
    And I fill in "Email" with "joe@getshrink.com"
    And I fill in "Password" with "joe123"
    And I fill in "Password confirmation" with "joe123"
    And I press "Create User"
    Then I should see "User created successfully."
    And I should have a user with email "joe@getshrink.com"
