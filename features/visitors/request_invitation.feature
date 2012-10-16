# encoding: utf-8

Feature: Request Invitation
  As a visitor to the website
  I want to request an invitation
  so I can be notified when the site is launched

  Background:
    Given I am not logged in

  Scenario: Owner views home page
    When I visit the home page
    Then I should see a button "Sou Proprietário"

@javascript
  Scenario: Owner views invitation request form
    When I visit the home page
    And I click a button "Sou Proprietário"
    Then I should see a form with a field "Email"
    
  Scenario: Vet views home page
    When I visit the home page
    Then I should see a button "Sou Veterinário"

@javascript
  Scenario: Vet views invitation request form
    When I visit the home page
    And I click a button "Sou Veterinário"
    Then I should see a form with a field "Email"

  Scenario: User signs up with valid data
    When I request an invitation with valid user data
    Then I should see a message "Thank You"
    And my email address should be stored in the database
    And my account should be unconfirmed

  Scenario: User signs up with invalid email
    When I request an invitation with an invalid email
    Then I should see an invalid email message
