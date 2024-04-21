class CalendarsController < ApplicationController
    before_action :require_login

    def show
        start_date = Date.today
        end_date = start_date.end_of_week
        @events = current_user.events.where(start_time: start_date.beginning_of_day..end_date.end_of_day)
      end      

    def require_login
        unless session[:user_id] && User.exists?(session[:user_id])
          flash[:alert] = 'Must sign in to use this feature.'
          redirect_to sign_in_path
        end
    end

end