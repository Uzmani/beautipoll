class CreateQuestionsTable < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.belongs_to :survey
      t.string :type, :multimedia
      t.text :content
      t.integer :position
      t.timestamps
    end
  end
end
