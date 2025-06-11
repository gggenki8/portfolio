class ApplicationController < ActionController::Base
    # Devise コントローラを経由するアクションが呼ばれる前に、下記メソッドを実行する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :role, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
  end
  
  private

  def configure_permitted_parameters
    # サインアップ時に :name, :image, :profile を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :image, :profile, :user_type,:career, :interest])

    # アカウント編集（更新）時にも許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :image, :profile, :user_type, :career, :interest])
  end
end
