require 'rails_helper'

RSpec.describe "Comments API", type: :request do
  let!(:user) { create(:user) }
  let(:category) { create(:category) }
  let!(:publication) { create(:publication, user_id:user.id, category_id: category.id) }
  let!(:comments) { create_list(:comment, 3, user_id: user.id, publication_id: publication.id) }
  let(:user_id) { user.id }
  let(:id) { comments.first.id }

  describe '/GET /api/users/:user_id/comments' do
    before { get "/api/users/#{user_id}/comments" }

    it 'returns user\'s comments on a publication' do
      expect(json).not_to be_empty
      expect(json.size).to eq(3)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /api/users/:user_id/comments/:id' do
    before { get "/api/users/#{user_id}/comments/#{id}" }

    context 'when comment exists' do
      it 'returns comment' do
        expect(json['id']).to eq(id)
      end

      it 'returns ststus code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when comment does not exist' do
      let(:id) { 200 }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Comment/)
      end
    end
  end

  describe 'POST /api/users/:user_id/comments' do
    let(:valid_payload) { { 
      body: 'TDD is quite come work in the beginning but gets interesting with time',
      publication_id: id
    } }

    context 'when request is valid' do
      before { post "/api/users/#{user_id}/comments", params: valid_payload }
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      let(:invalid_payload) { { 
      body: 'TDD is quite come work in the beginning but gets interesting with time',
      publication_id: 100
    } }
      before { post "/api/users/#{user_id}/comments", params: invalid_payload }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Publication must exist/)
      end
    end
  end

  describe 'PUT /api/users/:user_id/comments/:id' do
    let(:valid_payload) { { body: 'The tests here are working fine in contrast to publication'} }

    before { put "/api/users/#{user_id}/comments/#{id}", params: valid_payload }

    context 'when comment exists' do
      it 'updates the commment' do
        updated_comment = Comment.find(id)
        expect(updated_comment.body).to match(/The tests here are working fine in contrast to publication/)
      end

      it 'returns status 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when comment does not exist' do
      let(:id) { 50 }
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /api/users/:user_id/comments/:id' do
    before { delete "/api/users/#{user_id}/comments/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
