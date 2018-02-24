require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:category) { FactoryBot.build(:category) }
  let(:game) {FactoryBot.build(:game) }
  let(:user) {FactoryBot.build(:user) }

  it "is valid with title, description, user, category" do
    expect(game).to be_valid
  end

  it "is invalid without user" do
    game.user = nil
    expect(game).to be_invalid
  end

  it "is invalid without title" do
    game.title = nil
    expect(game).to be_invalid
  end

  it "is invalid without description" do
    game.description = nil
    expect(game).to be_invalid
  end

  it "is invalid without creator" do
    game.creator = nil
    expect(game).to be_invalid
  end

   it "is invalid without category" do
    game.category = nil
    expect(game).to be_invalid
  end

  it "is valid without rule_link" do
    game.rule_link = nil
    expect(game).to be_valid
  end

end