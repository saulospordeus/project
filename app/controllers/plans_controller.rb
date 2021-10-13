class PlansController < ApplicationController

    def index
        if params[:search]
            @plans = Plan.where(title: params[:search])
        else
            @plans = Plan.all
        end
    end

    def new
        @plan = Plan.new
    end

    def create
        @plan = Plan.new(plan_params)
        @plan.user = current_user
        if @plan.save
            redirect_to plans_path #TODO REDIRECT TO @plan
        else
            render :new
        end
    end
     private

     def plan_params
       params.require(:plan).permit(:title, :description, :hability, :value,
                                        :limit_date, :presence_type)
    end
end