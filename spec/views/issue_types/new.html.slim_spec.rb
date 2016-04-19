require 'rails_helper'

RSpec.describe "issue_types/new", type: :view do
  before(:each) do
    assign(:issue_type, IssueType.new(
      :name => "MyString"
    ))
  end

  it "renders new issue_type form" do
    render

    assert_select "form[action=?][method=?]", issue_types_path, "post" do

      assert_select "input#issue_type_name[name=?]", "issue_type[name]"
    end
  end
end
