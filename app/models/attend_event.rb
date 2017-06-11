class AttendEvent < ApplicationRecord
  belongs_to :user
  belong_to :post
end
