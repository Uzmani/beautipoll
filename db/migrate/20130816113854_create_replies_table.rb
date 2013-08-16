class CreateRepliesTable < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.belongs_to :choice
      t.belongs_to :completed_survey
      t.string :content
      t.timestamps
    end
  end
end
