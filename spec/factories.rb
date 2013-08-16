FactoryGirl.define do

  factory :user do
    sequence(:name) { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@test.com"}
    password_hash "password"
  end

  factory :survey do
    user
    title "Test Survey"
    url "www.test_url.com"
    image_url "www.test_url.com/img.png"
    visibility 1

    factory :survey_with_questions do 
      ignore do 
        question_count 5
      end

      before(:create) do |survey, evaluator|
        FactoryGirl.create_list(:question, evaluator.question_count, survey: survey)
      end
    end
  end

  factory :question do
    format "html"
    content "Who is your favorite 12th Century Scottish King?"
    sequence(:position) { |n| n }
    survey
  end
end