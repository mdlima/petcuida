# encoding: utf-8

def new_user
  @user = {
    'Email' => "example@example.com"
  }
end

def new_vet
  @user = {
    'Nome'      => 'Test',
    'Sobrenome' => 'Vet',
    'Email'     => 'example@example.com',
    'Telefone'  => '11999990000',
    'CEP'       => '04100-000'
  }
  
end

def fill_and_submit_form_for user
  user.each do |key, value|
    fill_in key, :with => value
  end
  click_button "Cadastrar"
end


### GIVEN ###



### WHEN ###
When /^I fill in my email$/ do
  fill_in "Email", :with => new_user[:email]
end

When /^I request an invitation with valid ([^\W]+) data$/ do |user_type|
  if user_type.downcase == 'vet'
    visit path_to('vets sign up')
    fill_and_submit_form_for new_vet
  else
    visit path_to('sign up')
    fill_and_submit_form_for new_user
  end
  
end

When /^I request an invitation with an invalid email$/ do
  user = new_user.merge(:email => "notanemail")
  visit path_to('sign up')
  fill_and_submit_form_for user
end

### THEN ###
Then /^I should see the vets page$/ do
  page.should have_selector('title', :text => 'Veterinários')
end

Then /^I should see a message "([^\"]*)"$/ do |arg1|
  page.should have_content(arg1)
end

Then /^my email address should be stored in the database$/ do
  test_user = User.find_by_email("example@example.com")
  test_user.should respond_to(:email)
end

Then /^my account should be unconfirmed$/ do
  test_user = User.find_by_email("example@example.com")
  test_user.confirmed_at.should be_nil
end

Then /^my stored user type should be "([^"]*)"/ do |user_type|
  test_user = User.find_by_email("example@example.com")
  test_user.type.should == user_type
end

