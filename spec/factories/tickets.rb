FactoryGirl.define do
  factory :ticket do
    notified_by nil
    created_by nil
    aasm_state "MyString"
    title "MyString"
    description "MyString"
    closed_at "2016-04-19 14:51:58"
  end
end
