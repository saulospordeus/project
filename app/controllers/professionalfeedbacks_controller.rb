class ProfessionalfeedbacksController < ApplicationController

    def new
        @professionalfeedback = Professionalfeedback.new
    end

    def create
        @professionalfeedback = Professionalfeedback.new(pfeedback_params)
        @professionalfeedback.professional = professional.find(params[:professional_id])
        if @professionalfeedback.save
            redirect_to root_path
        else
            render :new
        end
    end

    private
    
    def pfeedback_params
        params.require(:professionalfeedback).permit(:tex, :rate)
    end
end
