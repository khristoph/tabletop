RSpec.describe GamesController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end
  end

  it "returns a 200 response" do
    get :index
    expect(response).to have_http_status "200"
  end

  describe "#show" do
    context "as an authorized user" do
      before do
        @game = FactoryBot.create(:game)
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        sign_in @user
        get :show, params: { id: @game.id }
        expect(response).to be_success
      end
    end

    context "as an unauthorized user" do
      before do
        @user = FactoryBot.create(:user)
        @game = FactoryBot.create(:game)
      end

      it "responds successfully" do
        get :show, params: { id: @game.id }
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end

    end
  end
end