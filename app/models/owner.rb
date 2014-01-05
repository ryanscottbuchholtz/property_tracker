class Owner < ActiveRecord::Base

validates_presence_of :first_name
validates_presence_of :last_name

validates_format_of :email_address, :with => /.+@.+\..+/i, message: 'Invalid E-mail address.  Please try again.'

end

