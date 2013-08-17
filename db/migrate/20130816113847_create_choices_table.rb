class CreateChoicesTable < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.belongs_to :question
      t.string :format, :content
      t.timestamps
    end
  end
end
