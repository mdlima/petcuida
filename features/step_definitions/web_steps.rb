# encoding: utf-8

### WHEN ###
When /^I go to the (.+) page$/ do |page|
  visit path_to(page)
end

When /^I click a (link|button) "([^"]*)"$/ do |arg0, arg1|
  click_on (arg1)
end


### THEN ###
Then /^I should see a button "([^\"]*)"$/ do |arg1|
  page.should have_button (arg1)
end

Then /^I should see a form with a field "([^"]*)"$/ do |arg1|
  page.should have_content (arg1)
end
