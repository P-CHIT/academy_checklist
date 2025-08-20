Feature: Task Management

    Scenario: User can creates a new task 
        Given I am on the task index page
        When I fill in "finish final exam" into the task title input
        And I click the create task button
        Then I should see a task titled "finish final exam"


    Scenario: User can update status task
        Given I am on the task index page
        When I fill in "complete Gitlab CI" into the task title input
        And I click the create task button
        Then I should see a task titled "complete Gitlab CI"
       