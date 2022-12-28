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
end
