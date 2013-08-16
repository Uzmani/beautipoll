class CreateSurveysTable < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :user
      t.string :title, :url, :image_url
      t.integer :visibility
      t.timestamps
    end
  end
end
