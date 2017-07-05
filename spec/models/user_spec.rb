require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates the name presence" do
    user = build(:invalid_user)
    user.valid?
    user.errors[:name].should_not be_empty
  end
  it "check that user is saving fine" do
    user = create(:user)
  end
end
