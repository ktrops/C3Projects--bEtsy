require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #show" do
    it "displays information related to the given record" do
      User.create(username: "Sue Boo", email: "sue.boo@example.com",
        password: "password", password_confirmation: "password")
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

      it "creates a user record" do
        post :create, user_params
        expect(User.count).to eq 1
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
        expect(User.count).to eq 0
      end

      it "redirects to the #new page after input fails" do
        post :create, user_params
        expect(response).to redirect_to(register_path)
      end
    end #end of let
  end #end of describe block

  describe "PUT #edit" do
      it "updates an existing record" do
        user = User.create(username: "James Games", email: "james@email.com", password: "password", password_confirmation: "password")
        user.update(username: "James Thames", email: "james@email.com", password: "password", password_confirmation: "password")
        user.reload
        expect(user.username).to eq("James Thames")
      end
  end #end of describe block

end
