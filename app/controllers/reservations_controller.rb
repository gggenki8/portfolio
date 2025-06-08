# app/controllers/reservations_controller.rb

class ReservationsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservation, only: [:show, :approved, :update, :cancel, :mark_completed]
    before_action :set_skill_offering, only: [:new]
  
    # 【生徒向け】仮予約フォーム
    def new
      if @skill_offering.user == current_user
        redirect_to skill_offering_path(@skill_offering), alert: 'ご自身のレッスンは予約できません。'
        return
      end
  
      @reservation = current_user.reservations.build(skill_offering: @skill_offering)
    end
  
    # 【生徒向け】仮予約の作成
    def create
      @skill_offering = SkillOffering.find(reservation_params[:skill_offering_id])
  
      if @skill_offering.user == current_user
        redirect_to skill_offering_path(@skill_offering), alert: 'ご自身のレッスンは予約できません。'
        return
      end
  
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.status = "pending"  # 仮予約状態
  
      if @reservation.save
        redirect_to reservation_path(@reservation), notice: "仮予約を受け付けました。"
      else
        @skill_offering = SkillOffering.find(reservation_params[:skill_offering_id])
        render :new
      end
    end
  
    # 【生徒向け】仮予約完了画面
    def show
      if @reservation.completed?
        redirect_to approved_reservation_path(@reservation) and returnend
      end
    end
  
    # 【提供者／生徒共通】予約管理画面
    def index
      # --- 提供者向けリスト ---
      my_offering_ids = current_user.skill_offerings.pluck(:id)
      @pending_reservations  = Reservation.where(skill_offering_id: my_offering_ids, status: "pending")
                                          .order(created_at: :desc)
      @approved_reservations = Reservation.where(skill_offering_id: my_offering_ids, status: "approved")
                                          .order(created_at: :desc)
      @rejected_reservations = Reservation.where(skill_offering_id: my_offering_ids, status: "rejected")
                                          .order(created_at: :desc)
    
      # --- 生徒向けリスト（自分が予約したもの） ---
      @my_reservations = current_user.reservations
                                     .includes(:skill_offering, :review)  # ← ここで review をプリロード
                                     .where.not(status: "reviewed")
                                     .order(created_at: :desc)
    
      # --- 自分の提供しているレッスンを取得 ---
      @my_skill_offerings = current_user.skill_offerings.order(created_at: :desc)

      @received_reviews = Review
        .joins(reservation: :skill_offering)
        .where(skill_offerings: { user_id: current_user.id })
        .includes(:reservation)
        .order(created_at: :desc)

        Rails.logger.debug "⭐️ ReceivedReviews count: #{@received_reviews.size}"
    end
  
    # 【提供者向け】仮予約を承認 or 却下してステータスを更新
    def update
      if @reservation.skill_offering.user_id == current_user.id
        if params[:status] == "approved"
          @reservation.approved!
          flash[:notice] = "予約を承認しました。"
        elsif params[:status] == "rejected"
          @reservation.rejected!
          flash[:alert] = "予約を却下しました。"
        else
          flash[:alert] = "不正なステータスです。"
        end
      else
        flash[:alert] = "この予約を操作する権限がありません。"
      end
  
      redirect_to reservations_path
    end

    def approved
      unless @reservation.approved? || @reservation.completed?
        redirect_to reservation_path(@reservation), alert: "この画面は承認済みまたは完了済みの予約でしか利用できません"
        return
      end

      @messages = @reservation.messages.includes(:user).order(created_at: :asc)

      if @reservation.completed? && @reservation.user_id == current_user.id && @reservation.review.blank?
        @review = Review.new
      end
    end

    def mark_completed
      # 講師本人かつ承認済み予約以外は不可
      unless @reservation.skill_offering.user_id == current_user.id && @reservation.approved?
        redirect_to reservation_path(@reservation), alert: "この操作はできません"
        return
      end
  
      @reservation.update(status: :completed)
      redirect_to approved_reservation_path(@reservation), notice: "レッスンを完了とマークしました"
    end
  
    # 予約キャンセル（生徒用）
    def cancel
      # 予約者本人かつ承認済み予約以外は不可
      unless @reservation.user_id == current_user.id && @reservation.approved?
        redirect_to reservation_path(@reservation), alert: "この操作はできません"
        return
      end
  
      @reservation.update(status: :canceled)
      redirect_to reservations_path, notice: "予約をキャンセルしました"
    end

    private
  
    def set_reservation
      @reservation = Reservation.find_by(id: params[:id])
      unless @reservation
        redirect_to reservation_path, alert: "該当する予約が見つかりません" unless @reservation
      end
    end
  
    def set_skill_offering
      @skill_offering = SkillOffering.find(params[:skill_offering_id])
    end
  
    def reservation_params
      params.require(:reservation).permit(:skill_offering_id, :reserved_date, :reserved_time, :message)
    end

    def review_params
      params.require(:review).permit(:rating, :comment)
    end  
end