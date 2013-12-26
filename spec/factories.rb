FactoryGirl.define do
  factory :user do
    name "User T. Duncan"
    sequence :username do |n| "User #{n}" end
    email              "test@example.com"
    birthday           { 22.years.ago }
    agreed_to_terms_at { Time.now }
    visible true
    
    factory :shane do
      name     "Shane Becker"
      username "veganstraightedge"
      birthday { 32.years.ago }
    end
    
    factory :bookis do
      name     "Bookis Smuin"
      username "bookis"
      birthday { 27.years.ago }
    end
  end
  
  factory :block do
    user
    association :blocked_user, factory: :bookis
  end
end