# This controller handles the registration of new tenants and users.
class Api::V1::RegistrationsController < ApplicationController

  # Creates a new tenant and a user associated with that tenant.
  # This action extracts the tenant and user parameters from the request,
  # and uses the TenantUserCreationService to handle the creation process.
  # If the service successfully creates both records, a success message is returned.
  # If any error occurs during the creation process, an error message is returned.
  def create
    tenant_params = params.require(:tenant).permit(:name)
    user_params = params.require(:user).permit(:email, :password)

    service = TenantUserCreationService.new(tenant_params, user_params)
    begin
      service.call
      render json: { message: 'Registration successful' }, status: :created
    rescue ActiveRecord::RecordInvalid => e
      render json: { errors: e.message }, status: :unprocessable_entity
    end
  end

  private

  # Strong parameters for tenant creation.
  # This method ensures that only the permitted attributes are allowed for tenant creation.
  def tenant_params
    params.require(:tenant).permit(:name)
  end

  # Strong parameters for user creation.
  # This method ensures that only the permitted attributes are allowed for user creation.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end