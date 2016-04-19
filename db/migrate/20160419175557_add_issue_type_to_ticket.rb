class AddIssueTypeToTicket < ActiveRecord::Migration
  def change
    add_reference :tickets, :issue_type, index: true, foreign_key: true
  end
end
