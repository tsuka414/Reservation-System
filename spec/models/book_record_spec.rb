require 'rails_helper'

RSpec.describe BookRecord, type: :model do
  let!(:test_user) { create(:user) }

  # 各パラメータに問題がなければ、BookRecordモデルのインスタンスが有効になる。
  describe "An instance of the BookRecord model" do
    subject { test_book_record.valid? }

    context "when the correct parameters are entered" do
      let(:test_book_record) { build(:book_record, user: test_user) }

      it "is valid." do
        is_expected.to be_truthy
      end
    end
  end

  # 各カラムのバリデーションチェック
  describe "Direction validation in the BookRecord model" do
    subject { test_book_record.valid? }

    context "when direction is nil" do
      let(:test_book_record) { build(:book_record, user: test_user, direction: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when a value of 2 or more is specified for direction" do
      let(:test_book_record) { build(:book_record, user: test_user, direction: 2) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  describe "Category validation in the BookRecord model" do
    subject { test_book_record.valid? }

    context "when category is nil" do
      let(:test_book_record) { build(:book_record, user: test_user, category: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  describe "Amount validation in the BookRecord model" do
    subject { test_book_record.valid? }

    context "when amount is nil" do
      let(:test_book_record) { build(:book_record, user: test_user, amount: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when amount is zero" do
      let(:test_book_record) { build(:book_record, user: test_user, amount: 0) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when amount is negative" do
      let(:test_book_record) { build(:book_record, user: test_user, amount: -1) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  describe "RecordDate validation in the BookRecord model" do
    subject { test_book_record.valid? }

    context "when record_date is nil" do
      let(:test_book_record) { build(:book_record, user: test_user, record_date: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  describe "Comment validation in the BookRecord model" do
    subject { test_book_record.valid? }

    context "when comment is nil" do
      let(:test_book_record) { build(:book_record, user: test_user, comment: nil) }

      it "does pass." do
        is_expected.to be_truthy
      end
    end

    context "when comment is blank" do
      let(:test_book_record) { build(:book_record, user: test_user, comment: " " * 10) }

      it "does pass." do
        is_expected.to be_truthy
      end
    end

    context "when comment length is 141" do
      let(:test_book_record) { build(:book_record, user: test_user, comment: " " * 141) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end
end
