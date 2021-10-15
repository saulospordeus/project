class ApplicationController < ActionController::Base

    def authenticate
        if user_signed_in?
            authenticate_user!
        else
            authenticate_professional!
        end
    end

end
