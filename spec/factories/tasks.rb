FactoryBot.define do
  factory :task do
    title { "MyString" }
    content { "MyText" }
    deadline { "2023-02-27" }
    status { "MyString" }
    priority { "MyString" }
  end
end
