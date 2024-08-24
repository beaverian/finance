# This controller handles the registration of new tenants and users.
class Api::V1::RegistrationsController < ApplicationController

    # Creates a new tenant and a user associated with that tenant.
    def create
      tenant = Tenant.create!(tenant_params)
      user = tenant.users.create!(user_params)
      if user.persisted?
        render json: { message: 'Registration successful' }, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Strong parameters for tenant creation.
    def tenant_params
      params.require(:tenant).permit(:name)
    end
  
    # Strong parameters for user creation.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
  end