class HomeController < ApplicationController
  def index
    # 検索フォームのカテゴリプルダウン用
    @categories = Category.all

    # 常に新着用にデータ取得しておく
    @latest_offerings = SkillOffering.order(created_at: :desc).limit(5)

    # 検索条件があるときのみ @skill_offerings に絞り込み結果をセット
    if params[:q].present? || params[:category_id].present?
      @skill_offerings = SkillOffering.all
      if params[:q].present?
        kw = "%#{params[:q].strip}%"
        @skill_offerings = @skill_offerings.where("title LIKE :kw OR details LIKE :kw", kw: kw)
      end
      if params[:category_id].present?
        @skill_offerings = @skill_offerings.where(category_id: params[:category_id])
      end
    else
      @skill_offerings = []  # 検索していないときは空配列にしておく
    end
  end
end
