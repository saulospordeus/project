class ProfilesController < ApplicationController

   
    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.professional = current_professional
        if @profile.save
            redirect_to root_path #TODO REDIRECT TO @profile
        else
            render :new
        end
     end
     private

    def profile_params
       params.require(:profile).permit(:name, :social_name, :background, :description, :area)
    end
end