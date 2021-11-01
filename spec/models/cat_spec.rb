require 'rails_helper'

RSpec.describe Cat, type: :model do
  it "should validate name" do
    cat = Cat.create(age: 3, enjoys: 'Sleeping on the windowsill in the sunlight')
    expect(cat.errors[:name]).to_not be_empty
  end
  it "should validate age" do
    cat = Cat.create(name: 'Kitty', enjoys: 'Sleeping on the windowsill in the sunlight')
    expect(cat.errors[:age]).to_not be_empty
  end
  it "should validate enjoys" do
    cat = Cat.create(name: 'Kitty', age: 3)
    expect(cat.errors[:enjoys]).to_not be_empty
  end
end
