class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.references :notified_by, index: true
      t.references :created_by, index: true
      t.string :aasm_state
      t.string :title
      t.string :description
      t.datetime :closed_at

      t.timestamps null: false
    end
    add_foreign_key :tickets, :users, column: :notified_by_id
    add_foreign_key :tickets, :users, column: :created_by_id
  end
end
