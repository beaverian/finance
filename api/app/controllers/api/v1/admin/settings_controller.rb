module Api
    module V1
      module Admin
        class SettingsController < ApplicationController
          before_action :authorize_admin
  
          def show
            @settings = Tenant.find(params[:tenant_id])
            render json: @settings
          end
  
          def update
            @settings = Tenant.find(params[:tenant_id])
            if @settings.update(settings_params)
              render json: @settings
            else
              render json: @settings.errors, status: :unprocessable_entity
            end
          end
  
          private
  
          def settings_params
            params.require(:tenant).permit(:name, :other_setting)
          end
  
          def authorize_admin
            render json: { error: 'Not Authorized' }, status: 403 unless current_user.has_role?(:admin)
          end
        end
      end
    end
  end
  