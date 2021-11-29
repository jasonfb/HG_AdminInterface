FactoryBot.define do
  factory :invoice do
    account_id { 1 }
    number { "MyString" }
    work_started { "2021-11-29" }
    _total { 1.5 }
    paid_at { "2021-11-29 17:35:23" }
  end
end
