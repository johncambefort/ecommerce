FactoryBot.define do
  factory :promotion do
    product
    start_time { '2024-01-01'.to_datetime }
    end_time { '2024-01-20'.to_datetime }
    discount { 1.50 }
    discount_type { :flat }
  end
end
