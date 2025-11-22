require 'rails_helper'

RSpec.describe "/watches", type: :request do
  let(:invalid_attributes) {{}}
  let(:valid_headers) {{}}
  # let(:user) {
  #   User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
  # }
  # let(:property) {
  #   Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
  # }
  let(:valid_attributes) {
    {
      user_id: 1,
      property_id: 1
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      # binding.pry
      User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
      Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
      Watch.create! valid_attributes
      get watches_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
      Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
      watch = Watch.create! valid_attributes
      get watch_url(watch), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Watch" do
        User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
        Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
        expect {
          post watches_url,
               params: { watch: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Watch, :count).by(1)
      end

      it "renders a JSON response with the new watch" do
        User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
        Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
        post watches_url,
             params: { watch: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Watch" do
        expect {
          post watches_url,
               params: { watch: invalid_attributes }, as: :json
        }.to change(Watch, :count).by(0)
      end

      it "renders a JSON response with errors for the new watch" do
        post watches_url,
             params: { watch: invalid_attributes }, headers: valid_headers, as: :json
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

      it "updates the requested watch" do
        User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
        Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
        watch = Watch.create! valid_attributes
        patch watch_url(watch),
              params: { watch: new_attributes }, headers: valid_headers, as: :json
        watch.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the watch" do
        User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
        Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
        watch = Watch.create! valid_attributes
        patch watch_url(watch),
              params: { watch: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the watch" do
        User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
        Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
        watch = Watch.create! valid_attributes
        patch watch_url(watch),
              params: { watch: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:bad_request)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested watch" do
      User.create!(name: 'REX', email: 'rex@ror2.com', password: 'password', password_confirmation: 'password')
      Property.create!(title: 'Aphelian Sanctuary', description: 'Beautiful giant rings in the heart of Petrichor V.', price: 5555, bedrooms: 3, property_type: 1)
      watch = Watch.create! valid_attributes
      expect {
        delete watch_url(watch), headers: valid_headers, as: :json
      }.to change(Watch, :count).by(-1)
    end
  end
end
