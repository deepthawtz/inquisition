# encoding: UTF-8

Given /^there are no vocabulary words$/ do
  TestVocabulary.remove
  TestVocabulary.count.should == 0
end

Then /^I should see "([^\"]*)"$/ do |phrase|
  has_content?(phrase)
end

Given /^the vocab challenge is "([^\"]*)"$/ do |word|
  TestVocabulary.remove
  TestVocabulary.insert(:spanish => word, :english => "dog")
  visit "/reset"
  has_content?("perro") || has_content?("dog")
end

Then /^I should see a success message$/ do
  has_content?("¡correcto!")
end

Then /^I should see a vocab challenge$/ do
  visit "/"
  has_content?("What is this word")
  has_selector?(".inquisition")
end

Then /^I should see a failure message$/ do
  has_content?("You Fail")
end
