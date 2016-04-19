class CreateTicketsTags < ActiveRecord::Migration
  def change
    create_table :tickets_tags do |t|
      t.references :ticket, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
