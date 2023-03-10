FactoryBot.define do
  factory :user do
    name { "User" }
    email { "a@example.com" }
    password { "password" }
    password_confirmation { "password" }
    admin { false }
  end
end
