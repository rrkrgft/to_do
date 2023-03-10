require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user){ FactoryBot.create(:user) }
  before do
    visit new_session_path
    fill_in "Email", with: "a@example.com"
    fill_in "Password", with: "password"
    click_on "ログイン"
  end
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "test_title"
        fill_in "内容", with: "test_content"
        fill_in "期限", with: '002023-03-08'
        select "未着手", from: "ステータス"
        click_on "登録"
        expect(page).to have_content 'タスクを登録しました'
      end
    end
  end
  let!(:task){ FactoryBot.create(:task, title: 'task1', priority: '高', user: user)}
  let!(:task2){  FactoryBot.create(:task, title: 'task2', deadline: '2023/3/15', status: '完了', user: user) }
  let!(:task3){ FactoryBot.create(:task, title: 'task3', deadline: '2023/3/10', priority: '中', user: user) }
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        expect(page).to have_content 'task1'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
        expect(task_list[0]).to have_content("task3")
        expect(task_list[1]).to have_content("task2")
        expect(task_list[2]).to have_content("task1")
      end
    end
    context 'タスクが期限の降順に並んでいる場合' do
      it '期限が長いタスクが一番上に表示される' do
        click_on "期限"
        sleep 1.0
        task_list = all('.task_row')
        expect(task_list[0]).to have_content("task2")
        expect(task_list[1]).to have_content("task3")
        expect(task_list[2]).to have_content("task1")
      end
    end
    context '優先順位でソートする場合' do
      it '優先順位が高いタスクが一番上に表示される' do
        click_on "優先度"
        sleep 1.0
        task_list = all('.task_row')
        expect(task_list[0]).to have_content("task1")
        expect(task_list[1]).to have_content("task3")
        expect(task_list[2]).to have_content("task2")
      end
    end
    context '検索を使う場合' do
      it 'タイトルで検索' do
        fill_in 'search', with: '1' 
        click_on '検索'
        expect(page).to have_content("task1")
        expect(page).not_to have_content("task3")
      end
      it 'ステータスで検索' do
        select "完了", from: "select"
        click_on '検索'
        expect(page).to have_content("task2")
        expect(page).not_to have_content("task3")
      end
      it 'タイトルとステータスで検索' do
        fill_in 'search', with: '1' 
        select "未着手", from: "select"
        click_on '検索'
        expect(page).to have_content("task1")
        expect(page).not_to have_content("task3")
      end
    end
  end
  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        visit task_path(task)
        expect(page).to have_content 'task'
       end
     end
  end
end