class AddCompanyToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :company, index: true, foreign_key: true
  end
end
