class HomeController < ApplicationController
  def index
    @skill_offerings = SkillOffering.order(created_at: :desc).limit(10)
    @categories = Category.all
  end
end
