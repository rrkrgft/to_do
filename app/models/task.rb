class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum priority:{ 低: 0, 中: 1, 高: 2 }

  scope :order_by_priority, -> {
    order([])
  }

  scope :looks, -> (search){
    if search == ""
      return
    else
      where("title LIKE?", "%#{search}%")
    end
  }

  scope :looks2, -> (select){
    if select == ""
      return
    else
      where(status: "#{select}")
    end
  }

  scope :looks3, -> (select2){
    @looks3 = Label.where(labelname: select2).pluck(:id)
    @looks3 = Sort.where( label_id: @looks3).pluck(:task_id)
    if select2 == ''
      return
    else
      where( id: @looks3)
    end
  }

  belongs_to :user
  has_many :sorts, dependent: :destroy
  has_many :labels, through: :sorts, dependent: :destroy 
end
