class Task < ApplicationRecord
  validates :title, presence: true,
            length: { maximum: 100 }
  validates :content, presence: true,
            length: { maximum: 1000 }
  scope :latest, -> {order(end_date: :desc)}
  enum start_status: { '未着手': 0, '着手': 1, '完了': 2 }
end
