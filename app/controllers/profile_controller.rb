class ProfileController < ApplicationController
#
#    def new
#        @profile = Profile.new
#    end
#
#    def create
#        @profile = Profile.new(plan_params)
#        @profile.user = current_user
#        if @profile.save
#            redirect_to root_path #TODO REDIRECT TO @profile
#        else
#            render :new
#        end
#     end
#     
#     private
#
#     def plan_params
#       params.require(:profile).permit(:title, :description, :hability, :value,
#                                        :limit_date, :presence_type)
#     end
end
