Feature: getting inquisition'd on your Spanish vocabulary
    As a student 
    I want to be quizzed on Spanish vocabulary
    So that I may prosper in linguistic wealth
    
    Scenario: I get a vocab challenge right
        Given the vocab challenge is "perro"
        When I fill in "answer" with "sponge"
        And I click "Answer"
        Then I should see a success message
        And I should see a vocab challenge
    
    Scenario: I get a vocab challenge wrong
        Given the vocab challenge is "esponje"
        When I fill in "answer" with "george"
        And I click "Answer"
        Then I should see a failure message
        And I should see a vocab challenge
    
    # TODO: login, score,