class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.looks(search,select)
    if select == ""
      puts "ttest1"
      @task = Task.where("title LIKE?" ,"%#{search}%")
    elsif search == ""
      puts "ttest2"
      @task = Task.where(status: "#{select}")
    else
      puts "ttest3"
      @task = Task.where("title LIKE?","%#{search}%").where(status: "#{select}")
    end
  end
end
