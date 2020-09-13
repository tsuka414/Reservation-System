require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "#update" do
    let!(:test_user) { create(:user) }
    let!(:other_test_user) { create(:user) }

    context "as a user not to login" do
      # ログインしていない状態でupdateアクションを行うとログインページへリダイレクト
      it "redirects to the login page" do
        patch user_path(test_user), params: { user: attributes_for(:user, name: "Sample Name") }
        expect(response).to redirect_to "/login"
      end

      # ユーザー名が変更されないこと
      it "test_user.name does not change." do
        name = test_user.name
        patch user_path(test_user), params: { user: attributes_for(:user, name: "Sample Name") }
        expect(test_user.reload.name).to eq name
      end
    end
  end
end
