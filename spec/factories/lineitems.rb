FactoryBot.define do
  factory :lineitem do
    invoice_id { 1 }
    person_id { 1 }
    services_rendered_date { "2021-11-29" }
    price { 1.5 }
  end
end
