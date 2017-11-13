class DashboardController < ApplicationController
	def index

	if current_user.access_level.nil?
		current_user.update(access_level: 0)
	end
	end
end
