require 'rails_helper'
require 'benchmark'

RSpec.describe "/properties", type: :request do
  let(:valid_attributes) {
    {
      title: 'Aphelian Sanctuary',
      description: 'Beautiful giant rings in the heart of Petrichor V.',
      price: 5555,
      bedrooms: 3,
      property_type: 1
    }
  }

  describe "GET /show" do
    it "renders a successful response" do
      result = Benchmark.measure {
        1000.times do
          property = Property.create! valid_attributes
          get property_url(property), as: :json
          expect(response).to be_successful

          expect {
            delete property_url(property), headers: {}, as: :json
          }.to change(Property, :count).by(-1)
        end
      }
      puts "Benchmarking GET /show:"
      puts "   User       System     Total        Real (seconds)"
      puts result
    end
  end
end
