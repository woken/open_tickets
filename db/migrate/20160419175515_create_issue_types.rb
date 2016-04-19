class CreateIssueTypes < ActiveRecord::Migration
  def change
    create_table :issue_types do |t|
      t.string :name

      t.timestamps null: false
    end
    
    ['Bug', 'Usabilidad', 'Consistencia de datos'].each do |it|
      IssueType.where(name: it).first_or_create
    end

  end
end
