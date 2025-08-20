Given("I am on the task index page") do
  visit root_path
end

When("I fill in {string} into the task title input") do |title|
  find('[data-testid="task-title-input"]').fill_in(with: title)
end

When("I click the create task button") do
  find('[data-testid="create-task-button"]').click
end

Then("I should see a task titled {string}") do |title|
  expect(page).to have_content(title)
end

When("I click the delete button for {string}") do |title|
  # Find the task by its title text
  task_row = find('span', text: title).ancestor('div[id^="task_"]')
  task_id = task_row['id'].split('_').last
  
  # Click the delete button for this specific task
  within(task_row) do
    find("[data-testid='delete-task-button-#{task_id}']").click
  end
  
  # Wait for the turbo stream to complete the deletion
  sleep 0.1
end

Then("I should not see a task titled {string}") do |title|
  expect(page).to have_no_content(title)
end

When("I click the checkbox for {string}") do |title|
  # Find the task by its title text
  task_row = find('span', text: title).ancestor('div[id^="task_"]')
  task_id = task_row['id'].split('_').last
  
  # Click the checkbox for this specific task
  within(task_row) do
    find("[data-testid='task-status-checkbox-#{task_id}']").click
  end
end

Then("the task titled {string} checkbox should be checked") do |title|
  # Find the task by its title text
  task_row = find('span', text: title).ancestor('div[id^="task_"]')
  
  # Check if the task shows as completed (has line-through styling)
  within(task_row) do
    expect(page).to have_css('span.line-through', text: title)
  end
end