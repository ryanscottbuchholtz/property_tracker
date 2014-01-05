class Owner < ActiveRecord::Base
  validates_presence_of :first_name
  validates_presence_of :last_name

  validates_format_of :email_address, :with => /.+@.+\..+/i, message: 'Invalid E-mail address.  Please try again.'

  has_many :buildings, 
    inverse_of: :owner,
    dependent: :nullify

  def full_name
    "#{last_name}, #{first_name}  (#{email_address})"
  end



end

