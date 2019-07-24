require 'rails_helper'

RSpec.describe 'Work Orders API', type: :request do
  let!(:work_orders) { FactoryBot.create_list(:work_order, 10) }
  let(:work_order_id) { work_order.first.id }

  describe 'GET /work_orders' do
    before { get '/api/v1/work_orders' }

    it 'returns work_orders' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /work_orders' do
    let(:valid_attributes) do
      {
        title: 'Do Job',
        description: 'Some Job',
        deadline: 5.days.from_now
      }
    end

    context 'when the request is valid' do
      before { post '/api/v1/work_orders', params: valid_attributes }

      it 'creates a work_order' do
        expect(json['title']).to eq('Do Job')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/work_orders', params: {description: 'Foobar'} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Title can't be blank/)
      end
    end
  end

  describe 'GET /assign_worker' do
    let(:work_order) { FactoryBot.create(:work_order) }
    let(:worker) { FactoryBot.create(:worker) }

    context 'when the request is valid' do
      before { post "/api/v1/work_orders/#{work_order.id}/assign_worker/#{worker.id}" }

      it 'assigns a worker to a work order' do
        expect(json['workers']).to include(worker.as_json)
      end

      it 'returns a status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the request is invalid' do
      context 'when the worked_id is invalid' do
        before { post "/api/v1/work_orders/9999/assign_worker/#{worker.id}" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found error message' do
          expect(json['errors']).to match(/Couldn't find WorkOrder with 'id'=9999/)
        end
      end

      context 'when the work_order_id is invalid' do
        before { post "/api/v1/work_orders/#{work_order.id}/assign_worker/9999" }

        it 'returns status code 404' do
          expect(response).to have_http_status(404)
        end

        it 'returns a not found error message' do
          expect(json['errors']).to match(/Couldn't find Worker with 'id'=9999/)
        end
      end
    end
  end
end
