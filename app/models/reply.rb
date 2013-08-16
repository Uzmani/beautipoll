class Reply < ActiveRecord::Base
  belongs_to :choice
  belongs_to :completed_survey
end
