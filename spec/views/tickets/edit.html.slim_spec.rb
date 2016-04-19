require 'rails_helper'

RSpec.describe "tickets/edit", type: :view do
  before(:each) do
    @ticket = assign(:ticket, Ticket.create!(
      :notified_by => nil,
      :created_by => nil,
      :aasm_state => "MyString",
      :title => "MyString",
      :description => "MyString"
    ))
  end

  it "renders the edit ticket form" do
    render

    assert_select "form[action=?][method=?]", ticket_path(@ticket), "post" do

      assert_select "input#ticket_notified_by_id[name=?]", "ticket[notified_by_id]"

      assert_select "input#ticket_created_by_id[name=?]", "ticket[created_by_id]"

      assert_select "input#ticket_aasm_state[name=?]", "ticket[aasm_state]"

      assert_select "input#ticket_title[name=?]", "ticket[title]"

      assert_select "input#ticket_description[name=?]", "ticket[description]"
    end
  end
end
