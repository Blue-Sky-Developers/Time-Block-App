require 'rails_helper'

RSpec.describe CalendarsController, type: :controller do
  describe "GET #show" do
    let(:user) { FactoryBot.create(:user) }

    context "when user is logged in" do
      before do
        # Simulate a logged-in user
        session[:user_id] = user.id
      end

      it "assigns @events for the current user within the current week" do
        # Stub Current.user method to return the logged-in user
        allow(controller).to receive(:current_user).and_return(user)

        # Create events for the user within the current week
        start_date = Date.today
        event1 = FactoryBot.create(:event, user: user, start_time: start_date.beginning_of_week)
        event2 = FactoryBot.create(:event, user: user, start_time: start_date.end_of_week)

        get :show, params: { start_date: start_date }

        expect(assigns(:events)).to eq([event1, event2])
      end
    end

    context "when user is not logged in" do
      it "redirects to the sign in page with a flash message" do
        get :show
        expect(response).to redirect_to(sign_in_path)
        expect(flash[:alert]).to eq('Must sign in to use this feature.')
      end
    end
  end

  describe "require_login" do
    it "redirects to sign in page with a flash message if user is not logged in" do
      controller.send(:require_login)
      expect(response).to redirect_to(sign_in_path)
      expect(flash[:alert]).to eq('Must sign in to use this feature.')
    end

    it "does not redirect if user is logged in" do
      user = FactoryBot.create(:user)
      session[:user_id] = user.id

      controller.send(:require_login)
      expect(response).to be_nil
    end
  end
end
