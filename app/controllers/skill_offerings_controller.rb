class SkillOfferingsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_skill_offering, only: [:show, :edit, :update, :destroy]
  
    def index
      @categories = Category.all
      @skill_offerings = SkillOffering.all
  
      # フリーワード検索
      if params[:q].present?
        kw = "%#{params[:q].strip}%"
        @skill_offerings = @skill_offerings.where("title LIKE :kw OR details LIKE :kw", kw: kw)
      end
  
      # カテゴリ絞り込み
      if params[:category_id].present?
        @skill_offerings = @skill_offerings.where(category_id: params[:category_id])
      end
    end
  
    def new
      @skill_offering = current_user.skill_offerings.build
      @categories      = Category.all
    end
  
    def create
      @skill_offering = current_user.skill_offerings.build(skill_offering_params)
      if @skill_offering.save
        redirect_to @skill_offering, notice: 'スキルを登録しました。'
      else
        @categories = Category.all
        render :new
      end
    end
  
    def show
        @skill_offering = SkillOffering.find(params[:id])
    end
  
    def edit
      # 編集権限チェック：ログインユーザーが提供者でない場合リダイレクト
      redirect_to root_path, alert: '権限がありません' unless @skill_offering.user == current_user
      @categories = Category.all
    end
  
    def update
      if @skill_offering.update(skill_offering_params)
        redirect_to @skill_offering, notice: '登録を更新しました！'
      else
        @categories = Category.all
        render :edit
      end
    end
  
    def destroy
      # 削除権限チェック：ログインユーザーが提供者でない場合リダイレクト
      if @skill_offering.user == current_user
        @skill_offering.destroy
        redirect_to skill_offerings_path, notice: '登録を削除しました'
      else
        redirect_to root_path, alert: '権限がありません'
      end
    end
  
    def search
      @categories    = Category.all
      @q             = params[:q]
      @category_id   = params[:category_id]
      @duration      = params[:duration]
  
      @skill_offerings = SkillOffering.all
  
      # フリーワード検索
      if @q.present?
        @skill_offerings = @skill_offerings.where("details LIKE ?", "%#{@q}%")
      end
  
      # カテゴリ絞り込み
      if @category_id.present?
        @skill_offerings = @skill_offerings.where(category_id: @category_id)
      end
    end
  
    private
  
    def set_skill_offering
      @skill_offering = SkillOffering.find(params[:id])
    end
  
    def skill_offering_params
      params.require(:skill_offering).permit(:category_id, :available_time, :details)
    end
end
  
