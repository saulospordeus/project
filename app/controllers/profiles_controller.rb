class ProfilesController < ApplicationController

    before_action :authenticate_professional!, only: [:new, :create]
   
    def show
        @profile = Profile.find(params[:id])
    end

    def new
        @profile = Profile.new
    end

    def create
        @profile = Profile.new(profile_params)
        @profile.professional = current_professional
        if @profile.save
            redirect_to root_path, flash: {alert:"Perfil preenchido"}#
        else
            flash.now[:alert] = "Perfil não pode ser preenchido"
            render :new
        end
     end
     
     private

    def profile_params
       params.require(:profile).permit(:name, :social_name, :background, :description, :area)
    end
end