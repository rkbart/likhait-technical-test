require 'rails_helper'

RSpec.describe Expense, type: :model do
  let(:category) { Category.create!(name: "Food") }

  describe "future date validation" do
    it "allows expenses dated today" do
      expense = Expense.new(description: "Lunch", amount: 10.00, category: category, date: Date.today)
      expect(expense).to be_valid
    end

    it "allows expenses dated in the past" do
      expense = Expense.new(description: "Lunch", amount: 10.00, category: category, date: Date.today - 1)
      expect(expense).to be_valid
    end

    it "rejects expenses dated in the future" do
      expense = Expense.new(description: "Lunch", amount: 10.00, category: category, date: Date.today + 1)
      expect(expense).not_to be_valid
      expect(expense.errors[:date]).to include("can't be in the future")
    end
  end
end
