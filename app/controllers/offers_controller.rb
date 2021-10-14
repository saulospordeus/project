class OffersController < ApplicationController
    def new
        @offer = Offer.new
    end

    def create
        @offer = Offer.new(offer_params)
        @offer.professional = current_professional
        @offer.plan = Plan.find(params[:plan_id])
        if @offer.save
            redirect_to plans_path #TODO REDIRECT TO @plan
        else
            render :new
        end
    end
    
    private

    def offer_params
      params.require(:offer).permit(:description, :value, :hours, :finish_date)
    end

end

