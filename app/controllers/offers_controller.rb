class OffersController < ApplicationController
    def new
        @plan = Plan.find(params[:plan_id])
        @offer = Offer.new
    end

    def create
        @offer = Offer.new(offer_params)
        @offer.professional = current_professional
        @offer.plan = Plan.find(params[:plan_id])
        if @offer.save
            redirect_to plan_offer_path(id: @offer) #TODO REDIRECT TO @plan
        else
            redirect_to new_plan_offer_path
        end
    end

    def show
        @offer = Offer.find(params[:id])
        @plan = @offer.plan
    end
 
    private

    def offer_params
      params.require(:offer).permit(:description, :value, :hours, :finish_date)
    end

end

