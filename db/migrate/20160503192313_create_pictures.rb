class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :content
      t.references :imageable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
