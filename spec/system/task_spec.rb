require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_session_path
        fill_in 'session[email]', with: 'test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        visit new_task_path
        fill_in 'task[title]', with: 'new_test_title'
        fill_in 'task[content]', with: 'new_test_content'
        select '2023', from: 'task[end_date(1i)]'
        select '1月', from: 'task[end_date(2i)]'
        select '10', from: 'task[end_date(3i)]'
        select '完了', from: 'task[start_status]'
        select '中', from: 'task[priority]'
        click_button '登録する'
        expect(page).to have_content 'タスクを追加しました'
        expect(page).to have_content '完了'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, user: user) }
    before do
        visit new_session_path
        fill_in 'session[email]', with: 'test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
    end
    context '一覧画面に遷移した場合' do

      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'test_title'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = page.all('.task_row')
        expect(task_list[0]).to have_content 'test_content3'
        expect(task_list[1]).to have_content 'test_content2'
        expect(task_list[2]).to have_content 'test_content'
      end
    end
    context '「終了期限で並び替え」ボタンがクリックされた場合' do
      it '終了期限が一番未来のタスクが一番上に表示される' do
        visit tasks_path
        visit tasks_path(sort_end_date: "true")
        task_list = page.all('.task_row')
        expect(task_list[0]).to have_content '2023-01-03'
        expect(task_list[1]).to have_content '2023-01-02'
        expect(task_list[2]).to have_content '2023-01-01'
      end
    end
    context '「優先度で並び替え」ボタンがクリックされた場合' do
      it '優先度が高いタスクが一番上に表示される' do
        visit tasks_path
        visit tasks_path(sort_priority: "true")
        task_list = page.all('.task_row')
        expect(task_list[0]).to have_content '高'
        expect(task_list[1]).to have_content '中'
        expect(task_list[2]).to have_content '低'
      end
    end
  end
  describe '詳細表示機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, user: user) }
    before do
        visit new_session_path
        fill_in 'session[email]', with: 'test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
    end
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit tasks_path
        click_link "詳細", match: :first
        expect(page).to have_content "test_content3"
      end
    end
  end
  describe '検索機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:third_task) { FactoryBot.create(:third_task, user: user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test_user@example.com'
      fill_in 'session[password]', with: '111111'
      click_button 'Log in'
    end
    context 'タイトルで検索した場合' do
      it 'タイトルが部分一致したタスクが表示される' do
        visit tasks_path
        fill_in 'task[title]', with: '2'
        click_button "検索"
        expect(page).to have_content "中"
      end
    end
    context 'ステータスで検索した場合' do
      it 'ステータスと完全一致したタスクが表示される' do
        visit tasks_path
        select '完了', from: 'task[start_status]'
        click_button "検索"
        expect(page).to have_content "test_content3"
      end
    end
    context 'タイトルとステータス両方で検索した場合' do
      it '両方をand検索して一致したタスクが表示される' do
        visit tasks_path
        fill_in 'task[title]', with: 'title'
        select '未着手', from: 'task[start_status]'
        click_button "検索"
        expect(page).to have_content "test_content"
        expect(page).to have_content "未着手"
      end
    end
  end
end