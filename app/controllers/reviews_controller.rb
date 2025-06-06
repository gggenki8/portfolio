class ReviewsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservation

    def new
        # 「予約が completed」かつ「まだレビューがない」かつ「生徒本人」かをチェック
      unless @reservation.completed? && @reservation.review.blank? && @reservation.user_id == current_user.id
        redirect_to reservation_path(@reservation), alert: "レビューできません"
        return
      end
      @review = Review.new
    end
    
      # POST /reservations/:reservation_id/review
    def create
      @reservation = Reservation.find(params[:reservation_id])
      @review = @reservation.build_review(review_params)  # has_one なので build_review
      @review.user = current_user
    
      if @review.save
          # レビュー投稿と同時に予約は一覧から外す（レコード削除）
        @reservation.destroy
        redirect_to reservations_path, notice: "レビューを投稿しました"
      else
        flash.now[:alert] = "入力に誤りがあります"
        render :new
      end
    end
    
      # GET /reservations/:reservation_id/review
    def show
      @review = @reservation.review
      redirect_to reservation_path(@reservation), alert: "レビューが見つかりません" unless @review
    end
    
    private
    
    def set_reservation
      @reservation = Reservation.find_by(id: params[:reservation_id])
      redirect_to reservations_path, alert: "該当する予約が見つかりません" unless @reservation
    end
    
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
