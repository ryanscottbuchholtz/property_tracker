class Building < ActiveRecord::Base
  validates_presence_of :street_address, error_message: 'Please input Street Address'
  validates_presence_of :city, error_message: 'Please input City'
  validates_presence_of :state, error_message: 'Please select a State'
  validates_presence_of :postal_code

  validates :postal_code, length: { is: 5, message: 'Invalid Postal Code.  5 digits required.' } 
  validates_format_of :postal_code, with: /\A[0-9]+\z/, message: 'Invalid Postal Code, Numbers only'

  belongs_to :state,
    inverse_of: :buildings

end