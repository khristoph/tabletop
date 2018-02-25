

RSpec.describe ReviewsController, type: :controller do


  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @review = FactoryBot.create(:review)
        @game = FactoryBot.create(:game)
      end

      context "with valid attributes" do
        it "adds a review" do
          review_params = FactoryBot.attributes_for(:review)
          sign_in @user
          expect {
            post :create, params: { review: review_params, game_id: @game.id}
          }.to change(Review, :count).by(1)
        end
      end

      context "with invalid attributes" do
        it "does not add a review" do
          review_params = FactoryBot.attributes_for(:review, :invalid_review)
          sign_in @user
          expect {
            post :create, params: { review: review_params, game_id: @game.id }
          }.to_not change(Review, :count)
        end
      end
    end
  end

  describe "#new" do
    context "as a guest" do
      it "returns a 302 response" do
        @game = FactoryBot.create(:game)
        get :new, params: { game_id: @game.id }
        expect(response).to have_http_status "302"
      end

      it "redirects to the sign-in page" do
        @game = FactoryBot.create(:game)
        get :new, params: { game_id: @game.id }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#update" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @game = FactoryBot.create(:game)
        @review = FactoryBot.create(:review)
      end

      it "updates a review" do
        review_params = FactoryBot.attributes_for(:review,
          comment: "New comment")
        sign_in @user
        patch :update,
         params: { game_id: @game.id,
          id: @review.id,
          review: {:comment => "New comment"} }
        expect(@review.reload.comment).to eq "New comment"
      end
    end

    context "as a guest" do
      before do
        @game = FactoryBot.create(:game)
        @review = FactoryBot.create(:review)
      end

      it "redirects to the sign-in page" do
        review_params = FactoryBot.attributes_for(:review, comment: "New Comment")
        get :edit, params: { id: @review.id, game_id: @game.id}
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "#destroy" do
    context "as an authorized user" do
      before do
        @user = FactoryBot.create(:user)
        @game = FactoryBot.create(:game)
        @review = FactoryBot.create(:review)
      end

      it "deletes a review" do
        sign_in @user
        expect {
          delete :destroy, params: { id: @review.id, game_id: @game.id }
        }.to change(Review, :count).by(-1)
      end
    end


  end

end