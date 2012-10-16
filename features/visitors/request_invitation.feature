Feature: Request Invitation
  As a visitor to the website
  I want to request an invitation
  so I can be notified when the site is launched

  Background:
    Given I am not logged in

### Owner ###
  Scenario: Owner views home page
    When I visit the home page
    Then I should see a button "Sou Proprietário"

@javascript
  Scenario: Owner views invitation request form
    When I visit the home page
    And I click a button "Sou Proprietário"
    Then I should see a form with a field "Email"
    And my user type should be "Owner"

  Scenario: Owner signs up with valid data
    Given I am an Owner
    When I request an invitation with valid user data
    Then I should see a message "Thank You"
    And my email address should be stored in the database
    And my stored user type should be "Owner"
    And my account should be unconfirmed

### Vet ###
  Scenario: Vet views home page
    When I visit the home page
    Then I should see a button "Sou Veterinário"

@javascript
  Scenario: Vet views invitation request form
    When I visit the home page
    And I click a button "Sou Veterinário"
    Then I should see a form with a field "Email"

  Scenario: Vet signs up with valid data
    Given I am a Vet
    When I request an invitation with valid user data
    Then I should see a message "Thank You"
    And my email address should be stored in the database
    And my stored user type should be "Vet"
    And my account should be unconfirmed

### For all user types ###
  Scenario: User signs up with invalid email
    When I request an invitation with an invalid email
    Then I should see an invalid email message
