require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前・メール・パスワードがあれば有効' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'メールアドレスがなければエラー' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end
end