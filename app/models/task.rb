class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum priority:{ 低: 0, 中: 1, 高: 2 }

  scope :order_by_priority, -> {
    order([])
  }

  scope :looks, -> (search,select){
    if select == ""
      @task = Task.where("title LIKE?" ,"%#{search}%")
    elsif search == ""
      @task = Task.where(status: "#{select}")
    else
      @task = Task.where("title LIKE?","%#{search}%").where(status: "#{select}")
    end
  }

  belongs_to :user
  has_many :sorts, dependent: :destroy
  has_many :labels, through: :sorts, dependent: :destroy 
end
