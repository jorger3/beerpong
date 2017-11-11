class Match < ApplicationRecord
	belongs_to :tournaments, optional: true
	has_and_belongs_to_many :players, :order => "matches_players.id DESC"
end
