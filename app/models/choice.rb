class Choice < ActiveRecord::Base
  has_many :replies
  belongs_to :question
end
