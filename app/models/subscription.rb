class Subscription < ApplicationRecord
    belongs_to :user
    validates_uniqueness_of :user_id, scope: [:user_id, :network_id]
end
