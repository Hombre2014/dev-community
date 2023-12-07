FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    username {"#{Faker::Name.first_name.downcase}_#{rand(1..1000)}"}
    email {Faker::Internet.email}
    contact_number {Faker::PhoneNumber.phone_number_with_country_code}
    street_address {Faker::Address.street_address}
    city {Faker::Address.city}
    state {Faker::Address.state}
    country {Faker::Address.country}
    postcode {Faker::Address.postcode}
    date_of_birth {Faker::Date.birthday(min_age: 18, max_age: 65)}
    profile_title {User::PROFILE_TITLE.sample}
    password {'password'}
    about {Faker::Lorem.paragraph(sentence_count: 4)}
    confirmed_at {DateTime.now}
  end
end
