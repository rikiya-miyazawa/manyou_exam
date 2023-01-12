FactoryBot.define do
  factory :label do
    name { "DIC" }
  end
  factory :label2, class: Label do
    name { "Game" }
  end
end
