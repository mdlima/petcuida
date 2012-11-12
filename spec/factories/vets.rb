# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vet do
    name 'Test'
    last_name 'Vet'
    email 'example_vet@example.com'
    password 'please'
    password_confirmation 'please'
    phone '11999990000'
    zip_code '04100-000'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end