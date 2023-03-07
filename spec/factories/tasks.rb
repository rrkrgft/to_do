FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline { '2023/3/5' }
    status { '未着手' }
    priority { '低' }
  end
end
