require 'rails_helper'

RSpec.describe "tickets/index", type: :view do
  before(:each) do
    assign(:tickets, [
      Ticket.create!(
        :notified_by => nil,
        :created_by => nil,
        :aasm_state => "Aasm State",
        :title => "Title",
        :description => "Description"
      ),
      Ticket.create!(
        :notified_by => nil,
        :created_by => nil,
        :aasm_state => "Aasm State",
        :title => "Title",
        :description => "Description"
      )
    ])
  end

  it "renders a list of tickets" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Aasm State".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
