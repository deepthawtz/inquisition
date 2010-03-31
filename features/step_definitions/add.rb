Given /^there are vocabulary words$/ do
  Vocabulary.insert(:spanish => "gringo", :english => "white dude")
  Vocabulary.count.should == 1
end

Then /^I should see a form$/ do
  visit "/add"
  response_body.should contain("Add a New Vocabulary Word")
end

Then /^the new vocab term should be added$/ do
  Vocabulary.find(:spanish => "foto").count.should == 1
end
