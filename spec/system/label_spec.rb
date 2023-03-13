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
    context 'ラベルの削除ができる' do
      it 'ラベルの削除ができる' do
        accept_alert do
          click_on "削除"
        end
        expect(page).to have_content "ラベルを削除しました"
        expect(page).not_to have_content "仕事"
      end
    end
  end
  describe 'ラベルをタスクにつけられる' do
    let!(:label){ FactoryBot.create(:label)}
    context '新規作成の際にラベルをつけられる' do
      it '新規作成でラベルをつけられる' do
        visit new_task_path
        fill_in "タイトル", with: 'テスト'
        fill_in '内容', with: 'test'
        fill_in '期限', with: '002023/03/07'
        check "仕事"
        click_on "登録"
        expect(page).to have_content "仕事"
      end
    end
    context 'ラベルの編集ができる' do
      let!(:task){ FactoryBot.create(:task, user: user)}
      it '編集画面でラベルの変更ができる' do
        visit tasks_path
        click_on '編集'
        check "仕事"
        click_on "登録"
        expect(page).to have_content "仕事"
      end
    end
  end
  describe 'ラベルによる検索機能' do
    let!(:label){ FactoryBot.create(:label)}
    let!(:label2){ FactoryBot.create(:label, labelname: "趣味")}
    let!(:label3){ FactoryBot.create(:label, labelname: '家事')}
    let!(:task){ FactoryBot.create(:task,title: "test1", user: user )}
    let!(:task2){ FactoryBot.create(:task, title: "test2", user: user )}
    let!(:task3){ FactoryBot.create(:task, title: "test3", user: user )}
    before do
      visit edit_task_path(task)
      check "仕事"
      click_on "登録"
      visit edit_task_path(task2)
      check "趣味"
      click_on "登録"
      visit edit_task_path(task3)
      check "家事"
      click_on "登録"
    end
    context 'ラベルによる検索ができる' do
      it 'ラベルによる検索ができる' do
        visit tasks_path
        select "趣味", from: "select2"
        click_on "検索"
        expect(page).to have_content "test2"
        expect(page).not_to have_content "test3"
      end
    end
  end
end
