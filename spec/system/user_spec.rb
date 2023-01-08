require 'rails_helper'
RSpec.describe 'ユーザ管理機能テスト', type: :system do
  describe 'ユーザ新規登録機能テスト' do
    before do
      FactoryBot.create(:user)
    end
    context 'ユーザ新規登録した場合' do
      it 'ユーザのマイページが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: 'new_user_name'
        fill_in 'user[email]', with: 'new_user_name@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_button 'Create my account'
        expect(page).to have_content 'new_user_name'
      end
    end
    context 'ユーザがログインせずにタスク一覧に飛んだ場合' do
      it 'ログイン画面に遷移させる' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end
  describe 'セッション機能テスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user2) }
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'test_user@example.com'
      fill_in 'session[password]', with: '111111'
      click_button 'Log in'
    end
    context 'ユーザがログインした場合' do
      it 'ユーザのマイページが表示される' do
        expect(page).to have_content 'test_userのページ'
      end
    end
    context 'ユーザがログインしている場合' do
      it 'ログインしているユーザのマイページが閲覧できる' do
        click_link "タスク一覧"
        click_link "Profile"
        expect(page).to have_content 'test_userのページ'
      end
    end
    context 'ユーザが他人のマイページに飛んだ場合' do
      it '自分のタスク一覧に遷移させる' do
        visit new_task_path
        fill_in 'task[title]', with: 'new_test_title'
        fill_in 'task[content]', with: 'new_test_content'
        select '2023', from: 'task[end_date(1i)]'
        select '1月', from: 'task[end_date(2i)]'
        select '10', from: 'task[end_date(3i)]'
        select '完了', from: 'task[start_status]'
        select '中', from: 'task[priority]'
        click_button '登録する'
        visit user_path(user2)
        expect(page).to have_content 'new_test_title'
      end
    end
    context 'ユーザがログアウトボタンをクリックした場合' do
      it 'ログアウトできる' do
        click_link "Logout"
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面テスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    before do
      visit new_session_path
    end
    context '管理者ユーザが管理者画面ボタンを押した場合' do
      it '管理者画面のユーザ一覧が表示される' do
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        click_link "タスク一覧"
        click_link "管理者画面"
        expect(page).to have_content '管理者画面'
      end
    end
    context '一般ユーザが管理者画面ボタンを押した場合' do
      it '管理者画面にアクセスできず、タスク一覧に遷移させる' do
        fill_in 'session[email]', with: 'test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        click_link "タスク一覧"
        click_link "管理者画面"
        expect(page).to have_content '管理者のみアクセスできます'
      end
    end
    context '管理者がユーザを作成した場合' do
      it 'ユーザ一覧に新しくユーザが追加される' do
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        visit new_admin_user_path 
        fill_in 'user[name]', with: 'admin_sspec_test'
        fill_in 'user[email]', with: 'admin_sspec_test@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_button "Create user"
        expect(page).to have_content 'admin_sspec_test'
      end
    end
    context '管理者がユーザ詳細ボタンを押した場合' do
      it 'そのユーザの詳細ページが表示される' do
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        click_link "タスク一覧"
        click_link "管理者画面"
        visit admin_user_path(admin_user)
        expect(page).to have_content 'admin_test_user@example.com'
      end
    end
    context '管理者がユーザを編集した場合' do
      it 'ユーザ一に変更内容が適用される' do
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        visit admin_users_path
        visit edit_admin_user_path(admin_user)
        fill_in 'user[name]', with: 'admin_test_user_fuga'
        fill_in 'user[email]', with: 'admin_test_user@example.com'
        fill_in 'user[password]', with: '111111'
        fill_in 'user[password_confirmation]', with: '111111'
        click_button 'update user'
        visit admin_user_path(admin_user)
        expect(page).to have_content 'fuga'
      end
    end
    context '管理者がユーザを削除した場合' do
      it 'ユーザ一一覧からそのユーザが削除される' do
        fill_in 'session[email]', with: 'admin_test_user@example.com'
        fill_in 'session[password]', with: '111111'
        click_button 'Log in'
        visit admin_users_path
        click_link '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザを削除'
      end
    end
  end
end