require 'rails_helper'

RSpec.describe "issue_types/edit", type: :view do
  before(:each) do
    @issue_type = assign(:issue_type, IssueType.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit issue_type form" do
    render

    assert_select "form[action=?][method=?]", issue_type_path(@issue_type), "post" do

      assert_select "input#issue_type_name[name=?]", "issue_type[name]"
    end
  end
end
