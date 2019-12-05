class Saler < ApplicationRecord
    belongs_to :user
    has_one :item
end
