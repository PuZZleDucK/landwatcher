require 'rails_helper'

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
  let(:invalid_attributes) {{}}
  let(:valid_headers) {{}}

  describe "GET /index" do
    it "renders a successful response" do
      Property.create! valid_attributes
      get properties_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      property = Property.create! valid_attributes
      get property_url(property), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Property" do
        expect {
          post properties_url,
               params: { property: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Property, :count).by(1)
      end

      it "renders a JSON response with the new property" do
        post properties_url,
             params: { property: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Property" do
        expect {
          post properties_url,
               params: { property: invalid_attributes }, as: :json
        }.to change(Property, :count).by(0)
      end

      it "renders a JSON response with errors for the new property" do
        post properties_url,
             params: { property: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested property" do
        property = Property.create! valid_attributes
        patch property_url(property),
              params: { property: new_attributes }, headers: valid_headers, as: :json
        property.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the property" do
        property = Property.create! valid_attributes
        patch property_url(property),
              params: { property: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the property" do
        property = Property.create! valid_attributes
        patch property_url(property),
              params: { property: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested property" do
      property = Property.create! valid_attributes
      expect {
        delete property_url(property), headers: valid_headers, as: :json
      }.to change(Property, :count).by(-1)
    end
  end
end
