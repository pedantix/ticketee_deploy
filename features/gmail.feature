Feature: Gmail
  In order to send real world emails
  As the application
  I want to ensure my configuration is correct

  Background:
    Given there are the following users:
      | email              | password  |
      | alice@ticketee.com | password  |
      | sorbfsu@gmail.com  | Wond3ring |
    And Action Mailer delievers via SMTP

    Given there is a project called "TextMate 2"
    And "alice@ticketee.com" can view the "TextMate 2" project
    And "sorbfsu@gmail.com" can view the "TextMate 2" project
    And "sorbfsu@gmail.com" has created a ticket for this project:
       | title        | description       |
       | Release date | TBA very shortly. |

    Scenario: Receiving real world email
      Given I am signed in as "alice@ticketee.com"
      Given I am on the homepage
      When I follow "TextMate 2"
      And I follow "Release date"
      And I fill in "Text" with "Posting a comment!"
      And I press "Create Comment"
      Then I should see "Comment has been created."

      When I log into gmail with:
        | username           | password  |
        | sorbfsu@gmail.com  | Wond3ring |
      Then there should be an email from Ticketee in my inbox

