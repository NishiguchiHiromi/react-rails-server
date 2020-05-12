class Hobby < ApplicationRecord
  has_many :user_hobbies, dependent: :destroy
end
