require 'rails_helper'    # ← これが必須です

RSpec.describe "Reservations", type: :request do
  describe "PATCH /reservations/:id/mark_completed" do
    let(:tutor)       { create(:user) }
    let(:student)     { create(:user) }
    let(:offering)    { create(:skill_offering, user: tutor) }
    let!(:reservation){ create(:reservation, skill_offering: offering, user: student, status: "approved") }

    before { sign_in tutor }

    it "marks reservation as completed" do
      patch mark_completed_reservation_path(reservation)
      expect(reservation.reload.status).to eq "completed"
      expect(response).to redirect_to(approved_reservation_path(reservation))
      expect(flash[:notice]).to eq "レッスンを完了とマークしました"
    end
  end
end
