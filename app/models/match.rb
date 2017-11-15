class Match < ApplicationRecord
	belongs_to :tournaments, optional: true
	belongs_to :user, optional: false
	has_and_belongs_to_many :players, :order => "matches_players.id DESC"
end
