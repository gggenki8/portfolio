require 'rails_helper'

RSpec.describe "Reviews", type: :request do
  describe "POST /reservations/:reservation_id/review" do
    let(:tutor)       { create(:user) }
    let(:student)     { create(:user) }
    let(:offering)    { create(:skill_offering, user: tutor) }
    let!(:reservation){ create(:reservation, skill_offering: offering, user: student, status: "completed") }

    before { sign_in student }

    context "with valid input" do
      it "creates a review" do
        expect {
          post reservation_review_path(reservation), params: { review: { rating: 5, comment: "Great!" } }
        }.to change(Review, :count).by(1)
        expect(reservation.reload.status).to eq "reviewed"
        expect(response).to redirect_to(reservations_path)
        expect(flash[:notice]).to eq "レビューを投稿しました"
      end
    end

    context "with invalid input" do
        it "does not create review and sets flash alert" do
            expect {
              post reservation_review_path(reservation), params: { review: { rating: nil, comment: "" } }
            }.not_to change(Review, :count)
            expect(response).to have_http_status(:ok)
            expect(flash.now[:alert]).to eq "入力に誤りがあります"
        end
    end
  end
end
