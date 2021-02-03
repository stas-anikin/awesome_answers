# Step 2 for Serializer- Run terminal command to generate this serializer
# rails g serializer question
class QuestionSerializer < ActiveModel::Serializer
  attributes(
    :id,
    :title,
    :body,
    :created_at,
    :updated_at,
    :view_count,
    :randomstuff,
    :like_count
  )

  def randomstuff
    "You can add anything to your json response, This is an example"
  end

  def like_count
    #  object refers to the instane of the model being serialized. kind of 'this' in js and 'self' in ruby
    object.likes.count
  end

  belongs_to :user, key: :author

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :full_name
  end

  has_many :answers

  class AnswerSerializer < ActiveModel::Serializer
    attributes :id, :body, :created_at, :updated_at, :author_full_name

    def author_full_name
      object.user&.full_name
    end
  end
end
