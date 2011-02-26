Feature: Users can add more Spanish vocabulary words
    As a Spanish learner
    I want to add more vocabulary words
    So that I may prosper in linguistic wealth

    Scenario: want to add a new vocabulary challenge
        Given there are vocabulary words
        When I go to "/"
        And I follow "add a new vocab term"
        Then I should see a form
        When I fill in "english" with "photo"
        And I fill in "spanish" with "foto"
        And I click "Add"
        Then the new vocab term should be added

