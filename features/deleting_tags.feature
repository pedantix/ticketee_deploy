Feature: Deleteing Tags
  In order to remove old tags
  As a user
  I want to click a button and make them go away

  Background: 
    Given there is a project called "Ticketee"
    And there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as them
    And "user@ticketee.com" can view the "Ticketee" project
    And "user@ticketee.com" can tag the "Ticketee" project
    And "user@ticketee.com" has created a ticket for this project:
      | title | description       | tags              |
      | A tag | Tagging a ticket! | this-tag-must-die |
    And I am on the homepage
    When I follow "Ticketee" within "#projects"
    And I follow "A tag"

    @javascript
    Scenario: Deleting a tag
      When I follow "delete-this-tag-must-die"
      #Then show me the page
      Then I should not see "this-tag-must-die"
