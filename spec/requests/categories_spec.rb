require 'rails_helper'

RSpec.describe "Categories API", type: :request do
  let(:categories) { create_list(:category, 10) }
  let(:category_id) { categories.first.id }

  describe "GET /api/categories" do
    before { get "/api/categories" }

    it 'returns categories' do
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/categories/:id' do
    before { get "/api/categories/#{category_id}" }

    context 'when category exists' do
      it 'returns the category' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(category_id) 
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when category does not exist' do
      let(:catgeory_id) { 50 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end

  describe 'POST /api/catgeories' do
    let(:valid_payload) { { name: 'Sci-Fi' } } 

    context 'when request is valid' do
      before { post "/api/categories", params: valid_payload }

      it 'creates a category' do
        expect(json['name']).to eq('Sci-Fi')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      let(:invalid_payload) { { name: ''} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /api/categories/:id' do
    let(:valid_payload) { { name: 'History' } }

    before { put "/api/categories/#{category_id}", params: valid_payload }

    context 'when category exists' do
      it 'updates the category' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when category does not exist' do
      let(:category_id) { 100 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Category/)
      end
    end
  end
end
