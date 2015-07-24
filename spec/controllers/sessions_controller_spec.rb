require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "POST #create" do

    it "is sessionless by default" do
     expect(session[:user_id]).to eq(nil)
    end

    it "creates a session given required params" do
      user = User.create(username: "James Games", email: "james@email.com", password: "password", password_confirmation: "password")
      session[:user_id] = user.id
      expect(session[:user_id]).to eq(1)
    end
  end

end
