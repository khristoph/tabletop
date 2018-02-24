require 'rails_helper'

RSpec.describe Category, :model do

  let(:category) {Category.new}
  it "is not valid without a name" do
    expect(category).not_to be_valid
  end

  it "is invalid with 20+ characters" do
    category.name = 'a' * 21
    expect(category).not_to be_valid
  end

  it "is valid with name" do
    category = FactoryBot.create(:category)
    expect(category).to  be_valid
  end
end