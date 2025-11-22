require 'rails_helper'

RSpec.describe Property, type: :model do
  context 'create basic properties' do
    it 'creates a property with valid attributes' do
      property = Property.new(
        title: 'Aphelian Sanctuary',
        description: 'Beautiful giant rings in the heart of Petrichor V.',
        price: 5555,
        bedrooms: 3,
        property_type: 1
      )
      user = User.new(
        name: 'REX'
      )
      watch = Watch.new(
        user: user,
        property: property
      )
      expect(watch).to be_valid
    end
  end
end
