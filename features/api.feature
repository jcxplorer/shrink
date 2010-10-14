Feature: API
  In order to store notifications
  the applications that fail all the time
  want to access our API to send the notification information
  
  Scenario: Send a notification as XML
    Given I have a project
    When the application receives the sample notification XML
    Then I should have a notification for the project
    And the notification should contain all the sample data
