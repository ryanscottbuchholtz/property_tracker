require 'spec_helper'

describe Building do
  describe 'validations' do
    let(:state) { FactoryGirl.build(:state)}
    let(:building) {FactoryGirl.create(:building, state: state) }
    let(:blank) { ['', nil] }

    it 'is valid when it has all required and valid attributes' do
      expect(building).to be_valid
    end

    it { should_not have_valid(:street_address).when(*blank) }
    it { should_not have_valid(:city).when(*blank) }
    it { should have_valid(:state).when(State.new) }
    it { should_not have_valid(:state).when(nil) }
    it { should_not have_valid(:postal_code).when(*blank, 2210, 022105) }
    it { should have_valid(:description).when(*blank) }
  
  end

  describe 'associations' do
    it { should belong_to :state }
    it { should belong_to :owner }
  
  end

end
