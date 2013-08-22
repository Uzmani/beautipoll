class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  has_many :completed_surveys

  validates :title, presence: true
  validates :user, presence: true

  mount_uploader :image, ImageUploader

end
