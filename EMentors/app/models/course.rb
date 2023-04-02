class Course < ApplicationRecord
  belongs_to :user
  validates :course_name, :course_description, :course_duration, :course_price, presence: true
  before_validation :ensure_teacher?

  private
  def ensure_teacher?
    unless user.teacher?
      errors.add(:user_id, "Must be a teacher to create a course")
      # throw :abort
    end
  end
end
