# Step 1 : Many to Many
# Generate the table

class Tag < ApplicationRecord
  before_save :downcase_name
  has_many :taggings, dependent: :destroy
  has_many :questions, through: :taggings
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # SCIENCES = Siences = sciences
  # The case_sensitive option will make uniqueness validation ignore case.
  # for example, two records with names 'Sciences' and 'SCIENCES' can't co-exsist
  private

  def downcase_name
    self.name&.downcase!
  end
end
