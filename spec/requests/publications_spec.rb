require 'rails_helper'

RSpec.describe 'Publications', type: :request do
  let!(:category) { create(:category) }
  let!(:user) { create(:user) }
  let!(:publications) { create_list(:publication, 5, user_id: user.id, category_id: category.id) }
  let(:id) { publications.first.id }
  let(:user_id) { user.id }

  describe 'GET /api/users/:user_id/publications' do
    before { get "/api/users/#{user_id}/publications" }

    it 'returns user\'s publications' do
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/users/:user_id/publications/:id' do
    before { get "/api/users/#{user_id}/publications/#{id}" }

    context 'when publication exists' do
      it 'returns the publication' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(id)
      end
    end

    context 'when publication does not exist' do
      let(:id) { 100 }

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Publication/)
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /api/users/:user_id/publications' do
    let(:valid_payload) { { title: 'The Time Machine', author: 'H.G. Wells', category_id: category.id } }

    context 'when request is valid' do
      before { post "/api/users/#{user_id}/publications", params: valid_payload }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      let(:invalid_params) { { title: 'The Lord of the Rings', author: 'J' } }

      before { post "/api/users/#{user_id}/publications", params: invalid_params }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Couldn't find Category without an ID/)
      end
    end
  end

  describe 'PUT /api/users/:user_id/publications/:id' do
    before { put "/api/users/#{user_id}/publications/#{id}", params: { title: 'The Hobbit' } }

    context 'when publication exists' do
      it 'updates the publication' do
        updated_publication = Publication.find(id)
        expect(updated_publication.title).to match('The Hobbit')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when publication does not exist' do
      let(:id) { 200 }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Publication/)
      end
    end
  end

  describe 'DELETE /api/users/:user_id/publications/:id' do
    before { delete "/api/users/#{user_id}/publications/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
