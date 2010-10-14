Feature: Manage projects
  In order to keep track of exceptions
  users
  need to have projects that will have associated exceptions

  Background:
    Given I am signed in
  
  Scenario: Creating a new project
    Given I am on the projects page
    And I have a user named "Jack Wood"
    And another user named "Jason Peterson"
    When I follow "Add a project"
    Then I should be on the new project page
    When I fill in "Name" with "Spicy Pork"
    And I check "Jack Wood"
    And I press "Create Project"
    Then I should see "Project created successfully."
    And I should have a project named "Spicy Pork"
    And the user "Jack Wood" associated with it
    But the user "Jason Peterson" should not be a part of the project

  Scenario: Editing an existing project
    Given I have a project named "Eggs and Ham"
    And I have a user named "John Peter" associated with it
    And I am on the projects page
    When I follow "Eggs and Ham"
    And I follow "Edit project"
    And I fill in "Name" with "Eggs and Bacon"
    And I uncheck "John Peter"
    And I press "Update Project"
    Then I should see "Project updated successfully."
    And I should have a project named "Eggs and Bacon"
    But I should have no project named "Eggs and Ham"
    And the project "Eggs and Bacon" should have no users

  Scenario: Removing a project
    Given I have a project named "Veggies Online"
    And I am on the projects page
    When I follow "Veggies Online"
    And I follow "Edit project"
    And I press "Remove this project"
    Then I should see "Project removed successfully."
    And I should have no project named "Veggies Online"

  Scenario: Checking the API token
    Given I have a project named "Fluffy"
    And I am on the projects page
    When I follow "Fluffy"
    Then I should see the API token
