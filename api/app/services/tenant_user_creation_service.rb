# Service object to handle the creation of a Tenant and its associated User.
class TenantUserCreationService
  # Initializes the service with tenant and user parameters.
  #
  # @param tenant_params [Hash] the parameters for creating a Tenant.
  # @param user_params [Hash] the parameters for creating a User.
  def initialize(tenant_params, user_params)
    @tenant_params = tenant_params
    @user_params = user_params
  end

  # Executes the creation of a Tenant and its associated User within a transaction.
  # If any part of the process fails, the transaction is rolled back.
  #
  # @raise [ActiveRecord::RecordInvalid] if the Tenant or User creation fails.
  def call
    ActiveRecord::Base.transaction do
      tenant = Tenant.create!(@tenant_params)
      user = tenant.users.create!(@user_params)
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle the error, e.g., log it or re-raise it
    raise e
  end
end