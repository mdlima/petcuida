Feature: Request Invitation
  As a visitor to the website
  I want to request an invitation
  so I can be notified when the site is launched

  Background:
    Given I am not logged in

### Owner ###
  Scenario: Owner views home page
    When I go to the home page
    Then I should see a button "Quero me cadastrar!"

@javascript
  Scenario: Owner views invitation request form
    When I go to the home page
    And I click a button "Quero me cadastrar!"
    Then I should see a form with a field "Email"

  Scenario: Owner signs up with valid data
    When I request an invitation with valid owner data
    Then I should see a message "Obrigado!"
    And my email address should be stored in the database
    And my stored user type should be "Owner"
    And my account should be unconfirmed
    And my ip should be "127.0.0.1"

### Vet ###
  Scenario: Vet views home page
    When I go to the home page
    And I click a link "Sou Veterinário"
    Then I should see the vets page

  Scenario: Vet views invitation request form
    When I go to the vets home page
    And I click a button "Quero me cadastrar!"
    Then I should see a form with a field "Email"
    And I should see a form with a field "Nome"
    And I should see a form with a field "Sobrenome"
    And I should see a form with a field "Telefone"
    And I should see a form with a field "CEP"
    And I should see a form with a field "Aceito receber emails"

  Scenario: Vet signs up with valid data
    When I request an invitation with valid vet data
    Then I should see a message "Obrigado!"
    And my email address should be stored in the database
    And my stored user type should be "Vet"
    And my account should be unconfirmed
    And my ip should be "127.0.0.1"

### For all user types ###
  Scenario: User signs up with invalid email
    When I request an invitation with an invalid email
    Then I should see an invalid email message
