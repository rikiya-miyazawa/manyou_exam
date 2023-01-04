FactoryBot.define do
  factory :task do
    # 下記の内容は実際に作成するカラム名に合わせて変更してください
    title { 'test_title' }
    content { 'test_content' }
    end_date { Date.new(2023, 1, 1) }
    start_status { 0 }
  end
end