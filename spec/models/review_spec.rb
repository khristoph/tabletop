RSpec.describe Review, type: :model do
  let(:game) {FactoryBot.build(:game) }
  let(:user) {FactoryBot.build(:user) }
  let(:review) {FactoryBot.build(:review) }

  it "is valid with rating, comment, user, game" do
    expect(review).to be_valid
  end

  it "is invalid without user" do
    review.user = nil
    expect(review).to be_invalid
  end

   it "is invalid without game" do
    review.game = nil
    expect(review).to be_invalid
  end

   it "is invalid without rating" do
    review.rating = nil
    expect(review).to be_invalid
  end

   it "is invalid without comment" do
    review.comment = nil
    expect(review).to be_invalid
  end



end