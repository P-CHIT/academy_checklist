require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:task) { Task.create!(title: "Sample Task") }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
      expect(assigns(:tasks)).to include(task)
      expect(assigns(:task)).to be_a_new(Task)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Task" do
        expect {
          post :create, params: { task: { title: "New Task" } }
        }.to change(Task, :count).by(1)
      end

      it "redirects to root path" do
        post :create, params: { task: { title: "New Task" } }
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Task" do
        expect {
          post :create, params: { task: { title: nil } }
        }.not_to change(Task, :count)
      end

      it "renders the index template" do
        post :create, params: { task: { title: nil } }
        expect(response).to render_template(:index)
      end
    end
  end

  describe "PATCH #toggle" do
    it "toggles the task status" do
      expect {
        patch :toggle, params: { id: task.id }
        task.reload
      }.to change(task, :status)
    end

    it "redirects to root path" do
      patch :toggle, params: { id: task.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      expect {
        delete :destroy, params: { id: task.id }
      }.to change(Task, :count).by(-1)
    end

    it "redirects to root path" do
      delete :destroy, params: { id: task.id }
      expect(response).to redirect_to(root_path)
    end
  end

  describe "GET #brag" do
    it "returns http success" do
      get :brag
      expect(response).to have_http_status(:success)
    end
  end
end
