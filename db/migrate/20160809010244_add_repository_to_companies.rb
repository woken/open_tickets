class AddRepositoryToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :repository, :string
  end
end
