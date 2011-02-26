Given /^there are vocabulary words$/ do
  TestVocabulary.insert(:spanish => "gringo", :english => "white dude")
  TestVocabulary.count.should >= 1
end

Then /^I should see a form$/ do
  has_selector?("form")
end

Then /^the new vocab term should be added$/ do
  TestVocabulary.find_one(:spanish => "foto").should_not be_nil
end
