class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum priority:{ 低: 0, 中: 1, 高: 2 }

  scope :order_by_priority, -> {
    order([])
  }

  scope :search_by_title, -> (search){
    where("title LIKE?", "%#{search}%") if search.present?
  }

  scope :search_by_status, -> (select){
    where(status: "#{select}") if select.present?
  }

  scope :search_by_labels, -> (select2){
    @looks3 = Sort.where( label_id: select2).pluck(:task_id)
    where( id: @looks3) if select2.present?
  }

  belongs_to :user
  has_many :sorts, dependent: :destroy
  has_many :labels, through: :sorts, dependent: :destroy 
end
