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
      fill_in 'Email', with: user1.email
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
    context 'ログアウトできるか' do
      it 'ログアウトできるか' do
        click_on 'ログアウト'
        expect(page).to have_content 'ログアウトしました'
        expect(page).to have_content 'Password'
      end
    end
  end
  describe '管理画面のテスト' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user_admin) { FactoryBot.create(:user, name: 'admin', email: 'admin@test.com', admin: 'true' ) } 
    context '管理画面のアクセス' do
      it '管理者は管理画面にアクセスできる' do
        visit new_session_path
        fill_in 'Email', with: 'admin@test.com'
        fill_in 'Password', with: 'password'
        click_on 'ログイン'
        visit admin_users_path
        expect(page).to have_content 'ユーザー名'
        expect(page).to have_content 'タスク登録件数'
      end
      it '管理権限なしは管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'Email', with: 'a@example.com'
        fill_in 'Password', with: 'password'
        click_on 'ログイン'
        visit admin_users_path
        expect(page).not_to have_content 'ユーザー名'
        expect(page).to have_content '優先度'
      end
    end
    context '管理ユーザが管理画面の操作を行える' do
      before do
        visit new_session_path
        fill_in 'Email', with: 'admin@test.com'
        fill_in 'Password', with: 'password'
        click_on 'ログイン'
      end
      it 'ユーザの新規登録ができる' do
        visit new_admin_user_path
        fill_in '名前', with: 'test2'
        fill_in 'メールアドレス', with: 'test2@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_on '登録'
        expect(page).to have_content 'ユーザー登録しました'
        expect(page).to have_content 'test2@test.com'
      end
      it 'ユーザーの詳細画面にアクセスできる' do
        visit admin_user_path(user1)
        expect(page).to have_content 'a@example.com'
        expect(page).to have_content '詳細画面'
      end
      it 'ユーザーを編集画面から編集できる' do
        visit edit_admin_user_path(user1)
        fill_in '名前', with: 'user1'
        click_on '登録'
        expect(page).to have_content '編集しました'
        expect(page).to have_content 'user1'
      end
      it 'ユーザーを削除できる' do
        visit admin_users_path
        accept_alert do
          click_on '削除', match: :first
        end
        expect(page).to have_content 'ユーザーを削除しました'
        expect(page).not_to have_content 'a@example.com'
      end
    end
  end
end