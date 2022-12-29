require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'new_test_title'
        fill_in 'task[content]', with: 'new_test_content'
        click_button 
        expect(page).to have_content 'タスクを追加しました'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列が
        # have_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task, title: 'task1')
        task = FactoryBot.create(:task, title: 'task2')
        task = FactoryBot.create(:task, title: 'task3')
        task = FactoryBot.create(:task, title: 'task4')
        visit tasks_path
        task_list = page.all('.task_row')
        expect(task_list[0]).to have_content 'task4'
        expect(task_list[1]).to have_content 'task3'
        expect(task_list[2]).to have_content 'task2'
        expect(task_list[3]).to have_content 'task1'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'show_test')
        visit tasks_path
        click_link "詳細"
        expect(page).to have_content "show_test"
      end
    end
  end
end