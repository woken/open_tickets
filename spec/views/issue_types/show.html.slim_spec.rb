require 'rails_helper'

RSpec.describe "issue_types/show", type: :view do
  before(:each) do
    @issue_type = assign(:issue_type, IssueType.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
