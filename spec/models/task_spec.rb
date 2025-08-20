require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'when create new task' do
    it 'is valid with valid attributes' do
      task = Task.new(title: "Test Task")
      expect(task).to be_valid
    end

    it 'is invalid without a title' do
      task = Task.new(title: nil)
      expect(task).not_to be_valid
    end
  end
end
