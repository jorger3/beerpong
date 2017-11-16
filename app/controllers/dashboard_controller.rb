class DashboardController < ApplicationController
	def index
		if user_signed_in? then
			if current_user.access_level.nil?
			  current_user.update(access_level: 0)
			end
			@tournaments = Tournament.where(finished: false)
			@matches = Match.all
		end


	end
end
