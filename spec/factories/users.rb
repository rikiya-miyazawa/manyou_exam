FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test_user@example.com" }
    password { '111111' }
    password_confirmation  { '111111' }
    admin { false }
  end
  factory :user2, class: User do
    name { "test_user2" }
    email { "test_user2@example.com" }
    password { '111111' }
    password_confirmation  { '111111' }
    admin { false }
  end
  factory :admin_user, class: User do
    name { "admin_test_user" }
    email { "admin_test_user@example.com" }
    password { '111111' }
    password_confirmation  { '111111' }
    admin { true }
  end
end
