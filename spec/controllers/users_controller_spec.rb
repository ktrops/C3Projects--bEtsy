require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    it "displays information related to the given record" do
      get :show, id: 1
      expect(User.find(1).username).to eq 'Sue Boo'
    end
  end

  describe "POST #create" do
    context "valid user params" do
      let(:user_params) do {
        user:{
          username: 'senor bob',
          email: 'bob@email.com',
          password: 'pass',
          password_confirmation: 'pass'
        }
      }
      end

      it "creates a board game record" do
        post :create, user_params
        expect(User.count).to eq 3
      end

      it "redirects to the login page" do
        post :create, user_params
        expect(response).to redirect_to(login_path)
      end #
    end # end of let

    # negative test, user params are invalid
    context "invalid board game params" do
      let(:user_params) do {
        user:{
          username: 'Bob',
        }
      }
      end

      it "does not persist invalid records" do
        post :create, user_params
        expect(User.count).to eq 2
      end

      it "redirects to the #new page after input fails" do
        post :create, user_params
        expect(response).to redirect_to(new_user_path)
      end
    end #end of let
  end #end of describe block
end
