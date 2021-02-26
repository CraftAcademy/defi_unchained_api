FactoryBot.define do
  factory :user do
    email { "user@gmail.com" }
    password { "password" }
    password_confirmation { "password" }
    
  end
end
