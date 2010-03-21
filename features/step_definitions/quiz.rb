Given /^the vocab challenge is "([^\"]*)"$/ do |challenge|
  visit "/"
  response_body.should contain("challenge")
end

Then /^I should see a success message$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a vocab challenge$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^I should see a failure message$/ do
  pending # express the regexp above with the code you wish you had
end