require 'rails_helper'

RSpec.describe "tickets/show", type: :view do
  before(:each) do
    @ticket = assign(:ticket, Ticket.create!(
      :notified_by => nil,
      :created_by => nil,
      :aasm_state => "Aasm State",
      :title => "Title",
      :description => "Description"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Aasm State/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
  end
end
