require 'rails_helper'

RSpec.describe Watch, type: :model do
  context 'create basic watch' do
    it 'creates a watch with valid user and property' do
      property = Property.new(
        title: 'Aphelian Sanctuary',
        description: 'Beautiful giant rings in the heart of Petrichor V.',
        price: 5555,
        bedrooms: 3,
        property_type: 1
      )
      
      expect(property).to be_valid
    end
  end
end
