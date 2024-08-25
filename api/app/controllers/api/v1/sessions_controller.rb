# This controller handles user sessions for the API.
class Api::V1::SessionsController < ApplicationController
  
  # The create action handles user login.
  # It finds the tenant based on the subdomain provided in the parameters.
  # If the tenant is found, it switches to the tenant's context and finds the user by email within that context.
  # If the user is found and authenticated with the provided password, it handles successful login by generating a JWT token and returning the user information.
  # If the user is not found or authentication fails, it handles failed login by returning an error message.
  # If the tenant is not found, it handles the tenant not found scenario by returning an error message.
  def create
    # tenant = Tenant.find_by(subdomain: params[:subdomain])
    # if tenant
    #   User.current_tenant = tenant
      user = User.find_by(email: params[:email])
      if user&.authenticate(params[:password])
        render json: { token: user.generate_jwt, user: user }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    # else
    #   render json: { error: 'Tenant not found' }, status: :not_found
    # end
  end
end