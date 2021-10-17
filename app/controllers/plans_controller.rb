class PlansController < ApplicationController

    before_action :authenticate, only: [:new, :create, :index]
    before_action :authenticate_user!, only: [:delete]
    
    def index
        if user_signed_in? #projetista
            @plans = Plan.where(user: current_user)
        else
            if params[:search] #profissional/freelancer
                open_plans = Plan.where(status: "open")
                @plans = open_plans.where(title: params[:search])
            else
                @plans = Plan.where(status: "open")
            end    
        end
    end

    def new
        @plan = Plan.new
    end

    def create
        @plan = Plan.new(plan_params)
        @plan.user = current_user
        if @plan.save
            redirect_to plans_path, flash: {alert:"Projeto criado"}
        else
            flash.now[:alert] = "Projeto não pode ser criado"
            render :new
        end
    end

    def destroy
        @plan = Plan.find(params[:id])
        @plan.destroy
        redirect_to plans_path, flash: {alert:"Projeto deletado"}
    end

    def close
        @plan = Plan.find(params[:id])
        @plan.close
        redirect_to plans_path, flash: {alert:"Projeto fechado"}
    end

    def open
        @plan = Plan.find(params[:id])
        @plan.open
        redirect_to plans_path, flash: {alert:"Projeto aberto"}
    end

     private

     def plan_params
       params.require(:plan).permit(:title, :description, :hability, :value,
                                        :limit_date, :presence_type)
    end
end