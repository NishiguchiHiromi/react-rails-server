# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  # include DeviseTokenAuth::Concerns::User

  MAX_SIGN_IN_FAILED_COUNT = 3

  has_secure_password
  attr_accessor :hobby_ids

  has_many :user_hobbies, dependent: :destroy
  has_many :hobbies, through: :user_hobbies

  enum gender: { man: 1, woman: 2, other: 3 }
  enum blood_type: { a: 1, b: 2, o: 3, ab: 4 }


  validates :name, presence: true
  validates :mail, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 8 }, if: proc { |r| r.password.present? }
  # present? では改行コードなどが検知できないため nil? で判定
  validates :password, check_password: true, if: proc { |r| !r.password.nil? }
  validates :gender, presence: true
  validates :blood_type, presence: true

  after_save :save_hobbies

  scope :active, -> { where("sign_in_failed_count < ?", MAX_SIGN_IN_FAILED_COUNT) }

  def to_hash
    {
      id: id,
      name: name,
      kana: kana,
      mail: mail,
      gender: gender_before_type_cast,
      blood_type: blood_type_before_type_cast,
      hobby_ids: hobbies.pluck(:id)
    }
  end
  
  def locked?
    MAX_SIGN_IN_FAILED_COUNT <= sign_in_failed_count
  end

  def increment_sign_in_failed!
    increment!(:sign_in_failed_count)
  end

  def reset_sign_in_failed_count!
    update!(sign_in_failed_count: 0)
  end

  private

  def save_hobbies
    return unless hobby_ids
    self.user_hobbies = hobby_ids.map { |id| user_hobbies.find_or_create_by!(hobby_id: id) }
  end
end
