require 'rails_helper'

RSpec.describe 'End-to-End User Flow', type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:other_teacher) { create(:user, email: 'other_teacher@example.com', password: 'password') }
  let!(:student)       { create(:user, email: 'student@example.com', password: 'password') }
  let!(:category)      { create(:category, name: 'Programming') }

  it 'allows a teacher to create a lesson, a student to reserve it, the teacher to approve and mark it completed, and the student to review' do
    # --- 他の講師がレッスンを新規作成する ---
    title          = 'Ruby Basics'
    available_time = '平日 10:00-20:00'
    details        = 'Learn Ruby fundamentals.'

    visit new_user_session_path
    fill_in 'メールアドレス', with: other_teacher.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'

    visit new_skill_offering_path
    fill_in 'タイトル', with: title
    select 'Programming', from: 'カテゴリ*'
    fill_in '提供可能な時間帯*', with: available_time
    fill_in 'レッスン内容*', with: details
    click_button '登録する'
    expect(page).to have_content(title)
    expect(page).to have_content(details)
    click_button 'ログアウト'

    # --- 学生が予約をする ---
    visit new_user_session_path
    fill_in 'メールアドレス', with: student.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    # ホームページ（トップページ）にレッスン一覧が表示される前提
    visit root_path
    # 詳細画面へ遷移するため「詳細を見る」リンク（クラス offering-button）をクリック
    expect(page).to have_link('詳細を見る', class: 'offering-button')
    find('a.offering-button', text: '詳細を見る', match: :first).click

    # 詳細画面で、予約ボタン「このレッスンを予約する」（クラス res-btn）をクリック
    expect(page).to have_link("このレッスンを予約する", class: 'res-btn')
    click_link "このレッスンを予約する"

    # 仮予約フォームの入力
    fill_in '希望日', with: Date.tomorrow.strftime('%Y-%m-%d')
    fill_in '希望時間（例: 10:00）', with: '10:00'
    fill_in 'メッセージ', with: 'Looking forward to the lesson'
    click_button '仮予約を送信する'
    expect(page).to have_content('仮予約の受付が完了しました')
    click_button 'ログアウト'

    # --- 他の講師が予約管理画面で承認・レッスン終了操作を行う ---
    visit new_user_session_path
    fill_in 'メールアドレス', with: other_teacher.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    # 予約管理画面（ダッシュボード）へ移動
    visit reservations_path

    # ① 予約管理画面の「承認待ちの仮予約」セクションで、該当予約の「承認」ボタンをクリック
    within('section', text: '承認待ちの仮予約') do
      click_button '承認'
    end

    # ② 「承認済みの予約」セクションに移動し、「詳細を確認」リンクをクリック
    within('section', text: '承認済みの予約') do
      expect(page).to have_link('詳細を確認', class: 'detail-link')
      click_link '詳細を確認'
    end

    # 予約詳細画面で「レッスン終了」ボタンを押す
    click_button 'レッスン終了'
    click_button 'ログアウト'

    # --- 学生がレビューを投稿する ---
    visit new_user_session_path
    fill_in 'メールアドレス', with: student.email
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
    # 生徒向けの「予約一覧」部分へ移動
    visit reservations_path

    within('section', text: 'あなたの予約一覧') do
      expect(page).to have_link('レビューを書く', class: 'btn-review')
      click_link 'レビューを書く'
    end

    # レビュー投稿フォームが表示されるので、フォームに入力して投稿
    expect(page).to have_content('レビューを投稿する')
    select "★★★★★", from: "評価"
    fill_in "コメント", with: "Great lesson!"
    click_button "投稿する"

  end
end

