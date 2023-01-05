require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(title: '', content: 'title失敗テスト')
        expect(task).not_to be_valid
      end
    end
    context 'タスクの内容が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(title: 'contont失敗テスト', content: '')
        expect(task).not_to be_valid
        #vaildがtrueでなければ(falseならば)テスト成功
        #空欄だとバリデーションに引っかかってfalseになる
      end
    end
    context 'タスクのタイトルと内容に中身が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(title: '成功テスト', content: '成功テスト')
        expect(task).to be_valid
        #.toでtrueならばテスト成功
      end
    end
  end
  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task, title: 'task') }
    let!(:second_task) { FactoryBot.create(:second_task, title: "sample") }
    let!(:third_task) { FactoryBot.create(:third_task, title: 'test3') }

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.title_search('task')).to include(task)
        expect(Task.title_search('task')).not_to include(second_task)
        expect(Task.title_search('task').count).to eq 1
      end
    end
    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.status_search('完了')).to include(third_task)
        expect(Task.status_search(2)).not_to include(task)
      end
    end
    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.title_search('test3').status_search('完了')).to include(third_task)
        expect(Task.title_search('task').status_search(0)).to include(task)
      end
    end
  end
end
