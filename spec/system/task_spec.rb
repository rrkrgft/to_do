require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: "test_title"
        fill_in "内容", with: "test_content"
        binding.pry
        fill_in "期限", with: date
        click_on "登録"
        expect(page).to have_content 'タスクを登録しました'
      end
    end
  end
  let!(:task){ FactoryBot.create(:task, title: 'task1')}
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
        FactoryBot.create(:task, title: 'task2')
        FactoryBot.create(:task, title: 'task3')
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list[0]).to have_content("task3")
        expect(task_list[1]).to have_content("task2")
        expect(task_list[2]).to have_content("task1")
      end
    end
    context 'タスクが期限の降順に並んでいる場合' do
      it '期限が長いタスクが一番上に表示される' do
        FactoryBot.create(:task, title: 'task2', deadline: '2023/3/15')
        FactoryBot.create(:task, title: 'task3', deadline: '2023/3/10')
        visit tasks_path
        click_on "期限"
        task_list = all('.task_row')
        expect(task_list[0]).to have_content("task2")
        expect(task_list[1]).to have_content("task3")
        expect(task_list[2]).to have_content("task1")
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