require 'rails_helper'
RSpec.describe 'ユーザー機能', type: :system do
  describe 'ユーザー登録のテスト' do
    context 'ユーザーの新規登録' do
      it 'ユーザーの新規登録ができる' do
        visit new_user_path
        fill_in '名前', with: 'test'
        fill_in 'メールアドレス', with: 'test@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on '登録'
        expect(page).to have_content 'ユーザー登録しました'
      end
    end
    context 'ログインせずに一覧ページにアクセス' do
      it 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
        expect(page).to have_content 'Password'
      end
    end
  end
  describe 'セッションのテスト' do
    let!(:user1) { FactoryBot.create(:user) }
    before do
      visit new_session_path
      fill_in 'Email', with: 'a@example.com'
      fill_in 'Password', with: 'password'
      click_on 'ログイン'
    end
    context 'ログインできるか' do
      it 'ログインできるか' do
        expect(page).to have_content 'ログインしました'
        expect(page).to have_content 'ステータス'
      end
    end
    context 'マイページを見られるか' do
      it 'マイページにいけるか' do
        visit user_path(user1)
        expect(page).to have_content 'ユーザー情報'
      end
    end
  end
end