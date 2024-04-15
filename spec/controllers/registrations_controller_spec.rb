require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do

  describe "GET #new" do
    it "initializes a new user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "POST #create" do

    context "with valid parameters" do
      let(:valid_attributes) { { email: "test@example.com", password: "password123", password_confirmation: "password123" } }

      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the root path with a notice" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Successfully created account")
      end

      it "sets a session for the user" do
        post :create, params: { user: valid_attributes }
        expect(session[:user_id]).not_to be_nil
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { email: "test", password: "pass", password_confirmation: "wrong" } }

      it "does not create a new User" do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
      end

      it "returns an unprocessable entity status" do
        post :create, params: { user: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    # Additional tests for white box methodologies:

    # Data access testing:
    it "accesses the user parameters" do
      expect(controller).to receive(:user_params).and_call_original
      post :create, params: { user: valid_attributes }
    end

    # Initialization testing:
    it "initializes user session after successful registration" do
      post :create, params: { user: valid_attributes }
      expect(session[:user_id]).to eq(User.find_by(email: valid_attributes[:email]).id)
    end
  end

end
