require 'rails_helper'
# rails g rspec:model JobPost



RSpec.describe JobPost, type: :model do
  describe "validates" do
    describe "title" do
    
    it "requires a title" do
      #given
      job_post = FactoryBot.build(:job_post, title: nil)
      #when 
      job_post.valid?

      #then
      expect(job_post.errors.messages).to(have_key(:title))

    end
    it 'title is unique' do
      persisted_job_post= FactoryBot.create(:job_post)
      job_post=FactoryBot.build(:job_post, title: persisted_job_post.title)
      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:title))
    end
  end
  describe 'description' do  
    it 'requires a description' do
      #given
      job_post=FactoryBot.build(:job_post, description: nil)
      #when
      job_post.valid?
      #then
      expect(job_post.errors.messages).to(have_key(:description))
    end
    it 'must be larger than 100 characters' do
      job_post = FactoryBot.build(:job_post, description: 'less than 100')
      job_post.valid?

      expect(job_post.errors.messages).to( have_key(:description))
    end
  end
  describe 'min_salary' do
    it 'salary_min must be a number greater than 30_000' do 
      job_post=FactoryBot.build(:job_post, min_salary: 25_000)
      job_post.valid?
      expect(job_post.errors.details[:min_salary][0][:error]).to(be(:greater_than_or_equal_to))
    end
  end

  describe 'location' do
    it 'is required' do
      job_post= FactoryBot.build(:job_post, location: nil)

      job_post.valid?

      expect(job_post.errors.messages).to(have_key(:location))
    end
  end
  end
  
end
