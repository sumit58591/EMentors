class Course < ApplicationRecord

  belongs_to :user
  validates :course_name, :course_description, :course_duration, :course_price, presence: true
  before_validation :ensure_teacher?

  include Discard::Model
  before_validation :ensure_teacher?
  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :topics, dependent: :destroy
  has_many :payments
  validates :course_name, presence: true, uniqueness: true
  validates :course_description, :course_duration, :course_price, presence: true
  
  private

  def ensure_teacher?
    errors.add(:user_id, "Must be a teacher to create a course") unless user&.teacher?
  end 
end
