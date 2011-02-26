Feature: Users can add more Spanish vocabulary words
    As a Spanish learner
    I want to add more vocabulary words
    So that I may prosper in linguistic wealth

    Scenario: clicking "add a word"
        Given there are vocabulary words
        When I go to "/"
        And I follow "add a word"
        Then I should see a form

    Scenario: adding a new vocabulary challenge
        Given I am on "/add"
        When I fill in "english" with "photo"
        And I fill in "spanish" with "foto"
        And I click "Add"
        Then the new vocab term should be added

