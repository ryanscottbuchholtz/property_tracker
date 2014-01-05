require 'spec_helper'

describe 'a real estate associate records a new building', %q{
  As a real estate associate
  I want to record a building
  So that I can refer back to pertinent information
} do

  # ACCEPTANCE CRITERIA
  # * I must specify a street address, city, state, and postal code
  # * Only US states can be specified
  # * I can optionally specify a description of the building
  # * If I enter all of the required information in the required format, the building is recorded.
  # * If I do not specify all of the required information in the required formats, the building is not recorded and I am presented with errors.
  # * Upon successfully creating a building, I am redirected so that I can record another building.

  context 'required information is provided (happy path)' do
    it 'creates a new building record' do
      state = FactoryGirl.create(:state)
      building = FactoryGirl.create :building, state: state

      visit new_building_path
            
      fill_in 'Street Address', with: building.street_address
      fill_in 'City', with: building.city
      select building.state.name, from: 'building_state_id'
      fill_in 'ZIP', with: building.postal_code

      click_on 'Record this building'

      expect(page).to have_content 'Building saved!'
      expect(page).to have_content 'Record new Property'

      end
    end

  context 'missing information is provided' do
    it 'throws errors when required information is not provided' do

      visit new_building_path

      click_on 'Record this building'

      expect(page).to_not have_content 'Building saved!'

    end
  end

  context 'invalid information is provided' do
    it 'throws an error when invalid zip code is provided' do
      state = FactoryGirl.create(:state)
      building = FactoryGirl.create :building, state: state

      visit new_building_path

      fill_in 'Street Address', with: building.street_address
      fill_in 'City', with: building.city
      select building.state.name, from: 'building_state_id'
      fill_in 'ZIP', with: 1234

      click_on 'Record this building'

      expect(page).to have_content 'Invalid Postal Code.  5 digits required.'
      expect(page).to_not have_content 'Building saved!'
    end

    it 'throws an error when invalid zip code is provided' do
      state = FactoryGirl.create(:state)
      building = FactoryGirl.create :building, state: state

      visit new_building_path

      fill_in 'Street Address', with: building.street_address
      fill_in 'City', with: building.city
      select building.state.name, from: 'building_state_id'
      fill_in 'ZIP', with: 'abcde'

      click_on 'Record this building'

      expect(page).to have_content 'Invalid Postal Code, Numbers only'
      expect(page).to_not have_content 'Building saved!'

    end
  end

end

