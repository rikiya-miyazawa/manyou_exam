FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    end_date { Date.new(2023, 1, 1) }
    start_status { 0 }
    priority { 0 }
  end
  factory :second_task, class: Task do
    title { 'test_title2' }
    content { 'test_content2' }
    end_date { Date.new(2023, 1, 2) }
    start_status { 1 }
    priority { 1 }
  end
  factory :third_task, class: Task do
    title { 'test_title3' }
    content { 'test_content3' }
    end_date { Date.new(2023, 1, 3) }
    start_status { 2 }
    priority { 2 }
  end
end