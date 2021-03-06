Feature: getting inquisition'd on your Spanish vocabulary
    As a student
    I want to be quizzed on Spanish vocabulary
    So that I may prosper in linguistic wealth

    Scenario: I am the first to play
        Given there are no vocabulary words
        When I go to "/"
        Then I should see "start adding words"

    Scenario: I get a vocab challenge right
        Given the vocab challenge is "perro"
        When I fill in "answer" with "dog"
        And I click "Answer"
        Then I should see a success message
        And I should see a vocab challenge

    Scenario: I get a vocab challenge wrong
        Given the vocab challenge is "esponje"
        When I fill in "answer" with "george"
        And I click "Answer"
        Then I should see a failure message

    # TODO: login, score,
