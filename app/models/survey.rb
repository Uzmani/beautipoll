class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :completed_surveys

  validates :title, presence: true
  validates :user, presence: true
  # validate :has_question?
  
  # def has_question?
  #   errors.add(:base, "Survey must have at least one question.") if self.questions.blank?
  # end

end
