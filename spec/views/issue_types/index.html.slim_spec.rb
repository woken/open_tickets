require 'rails_helper'

RSpec.describe "issue_types/index", type: :view do
  before(:each) do
    assign(:issue_types, [
      IssueType.create!(
        :name => "Name"
      ),
      IssueType.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of issue_types" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
