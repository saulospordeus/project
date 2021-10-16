class ProfilesController < ApplicationController

    before_action :authenticate_professional!, only: [:new, :create]
   
    def show
        @profile = Profile.find(params[:id])
        @professional = @profile.professional
        @plans = @professional.plans
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

     def edit
        @profile = Profile.find(params[:id])
     end

     def update
        @profile = Profile.find(params[:id])
        if @profile.update(profile_params)
            redirect_to root_path, notice: "Perfil editado com sucesso"
            else
            flash.now[:alert] = "Perfil não foi editado"
            render :edit # ver se isso vai dar certo
        end
     end
     
     private

    def profile_params
       params.require(:profile).permit(:name, :social_name, :background, :description, :area)
    end
end