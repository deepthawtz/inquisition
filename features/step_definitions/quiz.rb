Given /^there are no vocabulary words$/ do
  Vocabulary.remove
  Vocabulary.count.should == 0
end

Then /^I should see "([^\"]*)"$/ do |phrase|
  response_body.should contain(phrase)
end

Given /^the vocab challenge is "([^\"]*)" \(correct\)$/ do |word|
  Vocabulary.remove
  Vocabulary.insert(:spanish => word, :english => "dog")
  visit "/reset"
  response_body.should contain(/perro|dog/)
end

Given /^the vocab challenge is "([^\"]*)" \(incorrect\)$/ do |word|
  Vocabulary.remove
  Vocabulary.insert(:spanish => word, :english => "sponge")
  visit "/reset"
  response_body.should contain(/esponje|sponge/)
end

Then /^I should see a success message$/ do
  visit "/?success=1"
  response_body.should contain("¡correcto!")
end

Then /^I should see a vocab challenge$/ do
  visit "/"
  response_body.should contain("What is this word")
  response_body.should have_selector(:class => "inquisition")
end

Then /^I should see a failure message$/ do
  response_body.should contain("You Fail")
end