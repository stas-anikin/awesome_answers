RANDOM_HUNDRED_CHARS="hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello world hello worldhello world"

FactoryBot.define do
  factory :job_post do
    sequence(:title){ |n| Faker::Job.title + "#{n}"}
    description{ Faker::Job.field + "#{RANDOM_HUNDRED_CHARS}"}
    location{Faker::Address.city}
    min_salary{rand(80_000..200_000)}
    max_salary{rand(200_000..400_000)}
    association(:user, factory: :user)
  end
  

end


# FactoryBot.create(:job_post) 👈🏻 This will create the object and save it in a db

# FactoryBot.build(:job_post) 👈🏻 This will give us a object like .new

# FactoryBot.attributes_for(:job_post) This will generate only attributes for job_post