FactoryBot.define do
  factory :task do
    title { 'test_title' }
    content { 'test_content' }
    deadline { '2023/3/5' }
    status { 'ĉŞçĉ' }
    priority { 'ä½' }
  end
end
