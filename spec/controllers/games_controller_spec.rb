


RSpec.describe GamesController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
      end

      it "responds successfully" do
        sign_in @user
        get :index
        aggregate_failures do
          expect(response).to be_success
          expect(response).to have_http_status "200"
        end
      end
    end

    context "as a guest" do
      it "responds successfully" do
        get :index
        expect(response).to be_success
        expect(response).to have_http_status "200"
      end
    end
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
        @game = FactoryBot.create(:game)
      end

      context "with valid attributes" do
        it "adds a game" do
          game_params = FactoryBot.attributes_for(:game)
          sign_in @user
          expect {
            post :create, params: { game: game_params, category_id: @category.id}
          }.to change(Game, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not add a game" do
          game_params = FactoryBot.attributes_for(:game, :invalid)
          sign_in @user
          expect {
            post :create, params: { game: game_params }
          }.to_not change(Game, :count)
        end
      end
    end
  end

  describe "#new" do
    context "as a guest" do
      it "returns a 302 response" do
        game_params = FactoryBot.attributes_for(:game)
        get :new, params: { game: game_params }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        game_params = FactoryBot.attributes_for(:game)
        get :new, params: { game: game_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @game = FactoryBot.create(:game)
      end

      it "updates a game" do
        game_params = FactoryBot.attributes_for(:game,
          title: "New title")
        sign_in @user
        patch :update,
         params: { id: @game.id,
          category_id: @game.category_id,
          game: {:title => "New title"} }
        expect(@game.reload.title).to eq "New title"
      end
    end

    context "as a guest" do
      before do
        @game = FactoryBot.create(:game)
      end

      it "redirects to the sign-in page" do
        game_params = FactoryBot.attributes_for(:game)
        get :edit, params: { id: @game.id, game: game_params }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @game = FactoryBot.create(:game)
      end

      it "deletes a game" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @game.id }
        }.to change(Game, :count).by(-1)
      end
    end


  end

end