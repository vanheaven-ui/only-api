# spec/requests/categories_spec.rb
require 'rails_helper'

RSpec.describe 'Categories API', type: :request do
  # initialize test data
  let!(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id }

  # Test suite for GET /api/categories
  describe 'GET /api/categories' do
    # make HTTP get request before each example
    before { get '/api/categories' }

    it 'returns categories' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /api/categories/:id
  describe 'GET /api/categories/:id' do
    before { get "/api/categories/#{category_id}" }

    context 'when the record exists' do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:category_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  # Test suite for POST /api/categories
  describe 'POST /api/categories' do
    # valid payload
    let(:valid_attributes) { { name: 'Sci-Fi' } }

    context 'when the request is valid' do
      before { post '/api/categories', params: valid_attributes }

      it 'creates a category' do
        expect(json['name']).to eq('Sci-Fi')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/categories', params: {name: 'Hi'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/"Validation failed: Name is too short (minimum is 3 characters)"/)
      end
    end
  end

  # Test suite for PUT /api/categories/:id
  describe 'PUT /api/categories/:id' do
    let(:valid_attributes) { { name: 'History' } }

    context 'when the record exists' do
      before { put "/api/categories/#{category_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
end