Feature: Email notifications
  In order to be alerted about new exceptions
  as a user
  I want to be notified about the the projects that I'm involved in
  
  Scenario: Emails are sent for new notifications
    Given I have a project named "getshrink.com"
    When the application receives the sample notification XML
    Then I should have an email
    And the email subject should be "[getshrink.com] NameError: uninitialized constant Notification"
    And the email body should contain a link to the notification
