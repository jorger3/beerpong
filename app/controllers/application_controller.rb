class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token  
  #before_action :authenticate_user!
  layout :layout_by_resource

  def layout_by_resource
    if current_user then
      if current_user.access_level.nil?
        current_user.update(access_level: 0)
      end
      'application'
    else
    'application'
    end
  end
  layout :layout
  
    private
  
    def layout
      # only turn it off for login pages:
      is_a?(Devise::SessionsController) ? false : "application"
      # or turn layout off for every devise controller:
      !devise_controller? && "application"
    end

  # LOGIN OBLICATORIO
  # def layout_by_resource
  #   if current_user then
  #     if current_user.access_level.nil?
  #       current_user.update(access_level: 0)
  #     end
  #   	'application'
  #   else
	# 	'login'
  #   end
  # end
end
