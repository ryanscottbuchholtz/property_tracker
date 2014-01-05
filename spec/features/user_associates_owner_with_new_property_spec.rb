require 'spec_helper'

describe 'a real estate associate correlates an owner with a building', %q{
  As a real estate associate
  I want to correlate an owner with buildings
  So that I can refer back to pertinent information
} do

  # ACCEPTANCE CRITERIA
  # * When recording a building, I want to optionally associate the building with its rightful owner.
  # * If I delete an owner, the owner and it's primary key should no longer be associated with any properties.

  context 'required information is provided (happy path)' do
    it 'creates a new building record with an owner associated' do
      state = FactoryGirl.create(:state)
      building = FactoryGirl.create :building, state: state
      owner = FactoryGirl.create(:owner)

      visit new_building_path
               
      fill_in 'Street Address', with: building.street_address
      fill_in 'City', with: building.city
      select building.state.name, from: 'building_state_id'
      select owner.last_name, from: 'building_owner_id'
      fill_in 'ZIP', with: building.postal_code

      click_on 'Record this building'

      expect(page).to have_content 'Building saved!'
      expect(page).to have_content 'Record new Property'

    end  
  end

end