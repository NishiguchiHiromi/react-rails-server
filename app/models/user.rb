# frozen_string_literal: true

class User < ActiveRecord::Base
  MAX_SIGN_IN_FAILED_COUNT = 3

  has_secure_password

  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies
  has_many :user_departments, dependent: :destroy
  has_many :departments, through: :user_departments

  enum gender: { man: 1, woman: 2, other: 3 }
  enum blood_type: { a: 1, b: 2, o: 3, ab: 4 }


  validates :name, presence: true
  validates :mail, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: proc { |r| r.password.present? }
  # present? では改行コードなどが検知できないため nil? で判定
  validates :password, check_password: true, if: proc { |r| !r.password.nil? }
  validates :gender, presence: true
  validates :blood_type, presence: true

  scope :active, -> { where("sign_in_failed_count < ?", MAX_SIGN_IN_FAILED_COUNT) }
  
  def locked?
    MAX_SIGN_IN_FAILED_COUNT <= sign_in_failed_count
  end

  def increment_sign_in_failed!
    increment!(:sign_in_failed_count)
  end

  def reset_sign_in_failed_count!
    update!(sign_in_failed_count: 0)
  end
end
