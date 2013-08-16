class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :completed_surveys
end
