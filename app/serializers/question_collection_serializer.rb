class QuestionCollectionSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :view_count, :created_at
end
