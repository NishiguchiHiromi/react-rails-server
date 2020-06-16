class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :kana, :mail
  attribute :gender_before_type_cast, key: :gender
  attribute :blood_type_before_type_cast, key: :blood_type
  attributes :hobby_ids, :department_ids
end