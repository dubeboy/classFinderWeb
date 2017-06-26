class UserAccommodationShare < ApplicationRecord
  validates_presence_of :accom_id
  validates_presence_of :user_token
end
