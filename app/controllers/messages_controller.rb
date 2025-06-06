class MessagesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_reservation
  
    def create
      @message = @reservation.messages.build(message_params)
      @message.user = current_user
  
      if @message.save
        # 方法①：承認後画面へ戻す
        redirect_to approved_reservation_path(@reservation), notice: "メッセージを送信しました"
        
        # または、方法②：直前のページに戻す
        # redirect_back(fallback_location: approved_reservation_path(@reservation),
        #               notice: "メッセージを送信しました")
      else
        @messages = @reservation.messages.includes(:user).order(created_at: :asc)
        flash.now[:alert] = "メッセージを入力してください"
        render "reservations/approved"
      end
    end
  
    private
  
    def set_reservation
      @reservation = Reservation.find_by(id: params[:reservation_id])
      unless @reservation
        redirect_to reservations_path, alert: "該当する予約が見つかりません"
      end
    end
  
    def message_params
      params.require(:message).permit(:content)
    end
  end
  
