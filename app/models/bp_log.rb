class BpLog < ApplicationRecord
	belongs_to :tournaments, optional: true
    belongs_to :user, optional: true
    belongs_to :matches, optional: true
    belongs_to :players, optional: true
end
