class ProfessionalFeedbacksController < ApplicationController

    def new
        @feedback = ProfessionalFeedback.new
    end

    def create
        @feedback = ProfessionalFeedback.new(pfeedback_params)
        @feedback.professional = professional.find(params[:professional_id])
        if @feedback.save
            redirect_to plans_path
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
