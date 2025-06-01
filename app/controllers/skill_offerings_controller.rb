class SkillOfferingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_skill_offering, only: [:show, :edit, :update, :destroy]

  def index
    @skill_offerings = SkillOffering.all
  end

  def new
    @skill_offering = current_user.skill_offerings.build
    @categories     = Category.all
  end
    
  def create
    @skill_offering = current_user.skill_offerings.build(skill_offering_params)
      if @skill_offering.save
        redirect_to skill_offering_path(@skill_offering), notice: 'スキルを登録しました。'
      else
        @categories = Category.all
        render :new
    end
  end

  def show
    @skill_offering = SkillOffering.find(params[:id])
  end

  def edit
    @skill_offering == current_user
    @categories = Category.all
  end

  def update
    if @skill_offering.update(skill_offering_params)
        redirect_to @skill_offering, notice: "登録を更新しました！"
    else
        @categories = Category.all
        render :edit
    end
  end

  def destroy
    @skill_offering.destroy
    redirect_to skill_offering_path, notice: "登録を削除しました"
  end

  def search
    @categories = Category.all
    @q = params[:q]
    @category_id = params[:category_id]
    @duration = params[:duration]

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
    # 他のカラムを使うなら permit に追加
  end
end
