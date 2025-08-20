require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  let(:valid_attributes) { { title: "Test Task" } }
  let(:invalid_attributes) { { title: nil } }

  describe "GET /index" do
    it "renders a successful response" do
      Task.create!(valid_attributes)
      get root_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /tasks" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post tasks_path, params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to root path" do
        post tasks_path, params: { task: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post tasks_path, params: { task: invalid_attributes }
        }.not_to change(Task, :count)
      end

      it "renders the index template" do
        post tasks_path, params: { task: invalid_attributes }
        expect(response).to render_template(:index)
      end
    end
  end

  describe "PATCH /tasks/:id/toggle" do
    let!(:task) { Task.create!(valid_attributes) }

    it "toggles the task status" do
      expect {
        patch toggle_task_path(task)
        task.reload
      }.to change(task, :status)
    end

    it "redirects to root path" do
      patch toggle_task_path(task)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE /tasks/:id" do
    let!(:task) { Task.create!(valid_attributes) }

    it "destroys the requested task" do
      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to root path" do
      delete task_path(task)
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET /brag" do
    it "renders a successful response" do
      get brag_quests_path
      expect(response).to have_http_status(:success)
    end
  end
end
