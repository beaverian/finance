module Api
    module V1
      module Admin
        class UsersController < ApplicationController
          before_action :authorize_admin
          before_action :set_user, only: [:show, :update, :destroy]
  
          # GET /api/v1/admin/users
          def index
            @users = User.where(tenant: current_tenant)
            render json: @users
          end
  
          # GET /api/v1/admin/users/:id
          def show
            render json: @user
          end
  
          # POST /api/v1/admin/users
          def create
            @user = User.new(user_params)
            @user.tenant = current_tenant
  
            if @user.save
              render json: @user, status: :created
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end
  
          # PUT /api/v1/admin/users/:id
          def update
            if @user.update(user_params)
              render json: @user
            else
              render json: @user.errors, status: :unprocessable_entity
            end
          end
  
          # DELETE /api/v1/admin/users/:id
          def destroy
            @user.destroy
            head :no_content
          end
  
          private
  
          def set_user
            @user = User.find(params[:id])
          end
  
          def user_params
            params.require(:user).permit(:name, :email, :role)
          end
  
          def authorize_admin
            render json: { error: 'Not Authorized' }, status: 403 unless current_user.has_role?(:admin)
          end
        end
      end
    end
  end
  