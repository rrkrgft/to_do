require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  let!(:user){ FactoryBot.create(:user)}
  before do
    visit new_session_path
    fill_in "Email", with: "a@example.com"
    fill_in "Password", with: "password"
    click_on "ログイン"
  end
  describe 'ラベル登録のテスト' do
    context 'ラベルの新規登録' do
      it 'ラベルの新規登録ができる' do
        visit new_label_path
        fill_in "ラベル", with: "家事"
        click_on "登録"
        expect(page).to have_content "ラベルを登録しました"
        expect(page).to have_content "家事"
      end
    end
    let!(:label){ FactoryBot.create(:label)}
    before do
      visit labels_path
    end
    context 'ラベルの編集ができる' do
      it 'ラベルの編集ができる' do
        click_on "編集"
        fill_in "ラベル", with: "趣味"
        click_on "登録"
        expect(page).to have_content "ラベルを編集しました"
        expect(page).to have_content "趣味"
        expect(page).not_to have_content "仕事"
      end
    end
  end
end
