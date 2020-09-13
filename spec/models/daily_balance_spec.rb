require 'rails_helper'

RSpec.describe DailyBalance, type: :model do
  let!(:test_user) { create(:user) }

  # 各パラメータに問題がなければ、DailyBalanceモデルのインスタンスが有効になる。
  describe "An instance of the DailyBalance model" do
    subject { test_daily_balance.valid? }

    context "when the correct parameters are entered" do
      let(:test_daily_balance) { build(:daily_balance, user: test_user) }

      it "is valid." do
        is_expected.to be_truthy
      end
    end
  end

  # 各カラムのバリデーションチェック
  # income(収入)はバリデーションがexpenditure(支出)と同じなのでチェックは省略
  describe "Expenditure validation in the DailyBalance model" do
    subject { test_daily_balance.valid? }

    context "when expenditure is nil" do
      let(:test_daily_balance) { build(:daily_balance, user: test_user, expenditure: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when expenditure is negative" do
      let(:test_daily_balance) { build(:daily_balance, user: test_user, expenditure: -1000) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end

    context "when expenditure is zero" do
      let(:test_daily_balance) { build(:daily_balance, user: test_user, expenditure: 0) }

      it "does pass." do
        is_expected.to be_truthy
      end
    end
  end

  describe "RecordDate validation in the DailyBalance model" do
    subject { test_daily_balance.valid? }

    context "when record_date is nil" do
      let(:test_daily_balance) { build(:daily_balance, user: test_user, record_date: nil) }

      it "does not pass." do
        is_expected.to be_falsey
      end
    end
  end

  # model method
  describe "Output value" do
    let(:test_daily_balance) { build(:daily_balance, user: test_user) }

    context "when called dailybalance.user_name method" do
      it "is equal to the user name." do
        expect(test_daily_balance.user_name).to eq test_user.name
      end
    end

    context "when called dailybalance.expenditure_income_hashed method" do
      it "is obtained correctly in the hashed state." do
        expect(test_daily_balance.expenditure_income_hashed["収入"]).to eq test_daily_balance.income
        expect(test_daily_balance.expenditure_income_hashed["支出"]).to eq test_daily_balance.expenditure
      end
    end
  end
end
