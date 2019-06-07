require "rails_helper"

RSpec.describe V1::MessagesController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it "returns success" do
      subject

      expect(response).to be_success
    end
  end
end
