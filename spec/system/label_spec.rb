require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  describe '新規作成機能' do
    # let!(:label) { FactoryBot.create(:label) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    context 'ラベルを新規作成した場合' do
      it '作成したラベルが確認できる' do
        visit new_session_path
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        visit tasks_path
        click_link '管理者画面'
        click_link 'ラベル新規作成'
        fill_in 'label[name]', with: 'Spec Label'
        click_button 'Create label'
        expect(page).to have_content 'ラベルを作成'
      end
    end
  end
  describe 'ラベル登録,編集機能' do
    let!(:label) { FactoryBot.create(:label) }
    let!(:labeL2) { FactoryBot.create(:label2) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test_user@example.com'
      fill_in 'session[password]', with: '111111'
      click_button 'Log in'
    end
    context 'タスク新規投稿時にラベルの登録も同時にした場合' do
      it '作成したタスクに登録したラベル名が確認できる' do
        click_link 'タスク追加'
        fill_in 'task[title]', with: 'label_test_title'
        fill_in 'task[content]', with: 'label_test_content'
        select '2023', from: 'task[end_date(1i)]'
        select '1月', from: 'task[end_date(2i)]'
        select '12', from: 'task[end_date(3i)]'
        select '完了', from: 'task[start_status]'
        select '中', from: 'task[priority]'
        check 'DIC'
        click_button '登録する'
        expect(page).to have_content 'DIC'
      end
    end
    context 'タスク編集ページでラベルの編集をした場合' do
      it '編集したタスクのラベル名が変更できる' do
        click_link 'タスク一覧'
        click_link '編集', match: :first
        fill_in 'task[title]', with: 'edit_test_title'
        fill_in 'task[content]', with: 'edit_test_content'
        select '2023', from: 'task[end_date(1i)]'
        select '1月', from: 'task[end_date(2i)]'
        select '12', from: 'task[end_date(3i)]'
        select '完了', from: 'task[start_status]'
        select '中', from: 'task[priority]'
        check 'Game'
        click_button '更新する'
        expect(page).to have_content 'Game'
      end
    end
  end
  describe 'ラベル詳細確認機能' do
    let!(:label) { FactoryBot.create(:label) }
    let!(:labeL2) { FactoryBot.create(:label2) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test_user@example.com'
      fill_in 'session[password]', with: '111111'
      click_button 'Log in'
    end
    context 'タスクの詳細ページに遷移した場合' do
      it '登録したラベルの内容が確認できる' do
        click_link 'タスク一覧'
        click_link '編集', match: :first
        check 'Game'
        click_button '更新する'
        click_link '詳細', match: :first
        expect(page).to have_content 'Game'
      end
    end
  end
  describe 'ラベル検索機能' do
    let!(:label) { FactoryBot.create(:label) }
    let!(:labeL2) { FactoryBot.create(:label2) }
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test_user@example.com'
      fill_in 'session[password]', with: '111111'
      click_button 'Log in'
    end
    context 'ラベル名で検索した場合' do
      it '一致したラベル名が貼られているタスクが表示される' do
        click_link 'タスク一覧'
        click_link '編集', match: :first
        check 'Game'
        click_button '更新する'
        select 'Game', from: 'task[label_id]'
        click_button "検索"
        expect(page).to have_content 'Game'
      end
    end
  end
end