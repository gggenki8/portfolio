require 'rails_helper'

RSpec.describe Reservation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:skill_offering) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:reserved_date) }
    it { is_expected.to validate_presence_of(:reserved_time) }
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to validate_presence_of(:status) }
  end

  context 'factory' do
    it 'has a valid default factory' do
      expect(build(:reservation)).to be_valid
    end

    it 'can be created with :approved trait' do
      expect(create(:reservation, :approved).status).to eq 'approved'
    end

    it 'can be created with :cancelled trait' do
      expect(create(:reservation, :cancelled).status).to eq 'cancelled'
    end
  end
end
