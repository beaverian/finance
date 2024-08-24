class Api::V1::SessionsController < ApplicationController
    def create
      tenant = Tenant.find_by(subdomain: params[:subdomain])
      if tenant
        # Switch to the tenant's context
        User.current_tenant = tenant
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          # Handle successful login
        else
          # Handle failed login
        end
      else
        # Handle tenant not found
      end
    end
  end