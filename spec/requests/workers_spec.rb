require 'rails_helper'

RSpec.describe 'Workers API', type: :request do
  let!(:workers) { FactoryBot.create_list(:worker, 10) }
  let(:worker_id) { workers.first.id }

  describe 'POST /workers' do
    let(:valid_attributes) do
      {
        name: 'John Doe',
        company_name: 'Apple',
        email: 'john@doe.com'
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/workers', params: valid_attributes }

      it 'creates a worker' do
        expect(json['name']).to eq('John Doe')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/workers', params: {company_name: 'Foobar'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'DELETE /workers/:id' do
    before { delete "/api/v1/workers/#{worker_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
