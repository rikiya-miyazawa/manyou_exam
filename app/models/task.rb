class Task < ApplicationRecord
  validates :title, presence: true,
            length: { maximum: 100 }
  validates :content, presence: true,
            length: { maximum: 1000 }
  scope :sort_end_date, -> {order(end_date: :desc)}
  scope :latest, -> {order(created_at: :desc)}
  # scope :title_search, -> {where('title LIKE ?', "%#{params[:task][:title]}%")}

  enum start_status: { '未着手': 0, '着手': 1, '完了': 2 }
end
