require 'rails_helper'

RSpec.describe WorkOrder, type: :model do
  it { should have_many(:jobs) }
  it { should have_many(:workers).through(:jobs) }

  it { should validate_presence_of(:title) }

  it 'should destroy dependent jobs' do
    work_order = FactoryBot.create(:work_order)
    worker = FactoryBot.create(:worker)

    work_order.workers << worker
    expect { work_order.destroy }.to change { Job.count }.by(-1)
  end

  describe '#check_worker_limit' do
    let(:work_order) { FactoryBot.create(:work_order) }

    before do
      work_order.workers << FactoryBot.create_list(:worker, 5)
    end

    it 'should not allow more than 5 workers' do
      new_worker = FactoryBot.create(:worker)
      expect { work_order.workers << new_worker }.to raise_error(Exceptions::LimitReachedError)
    end
  end

  describe '#self.for_worker' do
    let(:work_orders) { FactoryBot.create_list(:work_order, 3) }
    let(:worker1) { FactoryBot.create(:worker) }
    let(:worker2) { FactoryBot.create(:worker) }
    let(:worker3) { FactoryBot.create(:worker) }

    before do
      work_orders.each_with_index do |wo, i|
        wo.workers << send("worker#{i + 1}")
      end
    end

    context 'when worker_id is NOT nil' do
      context 'when sort_by is NOT nil' do
        let(:worker_id) { worker1.id }
        let(:sort_by) { 'deadline' }

        before do
          wo = FactoryBot.create(:work_order)
          wo.workers << worker1
        end

        it 'should return work order for worker 1 sorted' do
          result = WorkOrder.for_worker(worker_id, sort_by)
          expect(result).to eq(worker1.work_orders.sort_by(&:deadline))
        end
      end

      context 'when sort_by is nil' do
        let(:worker_id) { worker1.id }
        let(:sort_by) { nil }

        it 'should return work orders for worker 1' do
          result = WorkOrder.for_worker(worker_id, sort_by)
          expect(result).to eq(worker1.work_orders)
        end
      end
    end

    context 'when worker_id is nil' do
      context 'when sort_by is NOT nil' do
        let(:worker_id) { nil }
        let(:sort_by) { 'deadline' }

        it 'should return all the work orders unfiltered but sorted' do
          result = WorkOrder.for_worker(worker_id, sort_by)
          expect(result).to eq(work_orders.sort_by(&:deadline))
        end
      end

      context 'when sort_by is nil' do
        let(:worker_id) { nil }
        let(:sort_by) { nil }

        it 'should return all the work orders unfiltered' do
          result = WorkOrder.for_worker(worker_id, sort_by)
          expect(result.count).to eq(3)
        end
      end
    end
  end
end
