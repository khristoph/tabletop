require 'pry'

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

  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @category = FactoryBot.create(:category)
        @game = Game.new(title: "Dixit", description: "Lorem ipsum", creator: "John Doe")
      end

      context "with valid attributes" do
        it "adds a game" do
          game_params = @game.attributes
          game_params["user_id"] = @user.id
          game_params["category_id"] = @category.id
          sign_in @user
          expect {
            post :create, params: {game: game_params}
          }.to change(Game, :count).by(1)
       end
      end

      context "with invalid attributes" do
        it "does not add a game" do
          game_params = @game.attributes
          sign_in @user
          expect {
            post :create, params: {game: game_params}
          }.to_not change(Game, :count)
       end
      end

     context "as a guest" do
      it "returns a 302 response" do
        game_params = FactoryBot.attributes_for(:game)
        post :create, params: { game: game_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        game_params = FactoryBot.attributes_for(:game)
        post :create, params: { game: game_params }
        expect(response).to redirect_to "/users/sign_in"
      end
    end


    end
  end
end