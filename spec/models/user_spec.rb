require 'rails_helper'

RSpec.describe User, type: :model do
  # ユーザー名、Eメールアドレス、パスワードに問題がない場合、Userモデルのインスタンスが有効になる。
  describe "An instance of the user model" do
    subject { test_user.valid? }

    context "when the correct parameters are entered" do
      let(:test_user) { build(:user) }

      it "is valid." do
        is_expected.to be_truthy
      end
    end
  end

  describe "Name validation in the user model" do
    subject { test_user.valid? }

    context "when name is blank" do
      let(:test_user) { build(:user, name: " " * 10) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when name exceeds 20 characters" do
      let(:test_user) { build(:user, name: "a" * 21) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  describe "Email validation in the user model" do
    subject { test_user.valid? }

    context "when email is blank" do
      let(:test_user) { build(:user, email: " " * 10) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when email exceeds 128 characters" do
      let(:test_user) { build(:user, email: "a" * 117 + "@example.com") }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when email address is already used by other user" do
      before do
        create(:user, email: "testuser@example.com")
      end
      let(:test_user) { build(:user, email: "TeStUsEr@example.com") }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when the email address string does not match the regular expression 'REGEX_FOR_VALID_EMAIL'" do
      context "if not including '@'" do
        let(:test_user) { build(:user, email: "example_example.com") }

        it "does not pass." do
          is_expected.to be_falsey
        end
      end

      context "if including blank" do
        let(:test_user) { build(:user, email: "example example.com") }

        it "does not pass." do
          is_expected.to be_falsey
        end
      end

      context "if not including period after '@' character" do
        let(:test_user) { build(:user, email: "example@example_com") }

        it "does not pass." do
          is_expected.to be_falsey
        end
      end

      context "if including '?'" do
        let(:test_user) { build(:user, email: "example_?@example.com") }

        it "does not pass." do
          is_expected.to be_falsey
        end
      end

      context "if placing period at last" do
        let(:test_user) { build(:user, email: "example@example.com.") }

        it "does not pass." do
          is_expected.to be_falsey
        end
      end
    end
  end

  describe "Password validation in the user model" do
    subject { test_user.valid? }

    context "when password is less than 7 characters" do
      let(:test_user) do
        build(:user, password: "a" * 7,
                     password_confirmation: "a" * 7)
      end

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when password is blank" do
      let(:test_user) do
        build(:user, password: " " * 8,
                     password_confirmation: " " * 8)
      end

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when password is nil" do
      let(:test_user) do
        build(:user, password: nil,
                     password_confirmation: nil)
      end

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when 'password' and 'password_confirmation' do not match" do
      let(:test_user) do
        build(:user, password_confirmation: "12345679")
      end

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end
end
