require 'rails_helper'

RSpec.describe Worker, type: :model do
  let(:worker) { FactoryBot.create(:worker) }
  let(:work_order) { FactoryBot.create(:work_order) }

  it { should have_many(:jobs) }
  it { should have_many(:work_orders).through(:jobs) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:email) }

  it { should allow_value('email@addresse.foo').for(:email) }
  it { should_not allow_value('foo').for(:email) }

  it 'should destroy dependent jobs' do
    work_order.workers << worker
    expect { worker.destroy }.to change { Job.count }.by(-1)
  end
end
