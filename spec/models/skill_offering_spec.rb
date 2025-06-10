require 'rails_helper'

RSpec.describe SkillOffering, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional(false) }
    it { is_expected.to belong_to(:category).optional(false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:available_time) }
    it { is_expected.to validate_presence_of(:details) }
  end

  context 'factory' do
    it 'has a valid factory' do
        expect(create(:skill_offering)).to be_valid
    end
  end
end

