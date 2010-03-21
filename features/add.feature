Feature: Users can add more Spanish vocabulary words
    As a Spanish learner
    I want to add more vocabulary words
    So that I may prosper in linguistic wealth
    
    Scenario: want to add a new vocabulary challenge
        When I go to the landing page
        And I follow "add a new vocab term"
        Then I should see a form
        When I fill in "english" with "photo"
        And I fill in "spanish" with "foto"
        And I click "Add"
        Then the a new vocab term should be added
        