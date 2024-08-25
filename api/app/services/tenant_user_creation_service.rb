# Service class for creating a Tenant and its associated User.
# This service ensures that the creation of both the Tenant and User is done within a transaction.
# If any part of the process fails, the transaction is rolled back to maintain data integrity.
class TenantUserCreationService
  def initialize(tenant_params, user_params)
    @tenant_params = tenant_params
    @user_params = user_params
  end

  # Executes the creation of a Tenant and its associated User within a transaction.
  # Before creating, it checks if the tenant name or user email already exists.
  # If any part of the process fails, the transaction is rolled back.
  #
  # @raise [ActiveRecord::RecordInvalid] if the Tenant or User creation fails.
  def call
    validate_params!
    ActiveRecord::Base.transaction do
      tenant = Tenant.create!(@tenant_params)
      user = tenant.users.create!(@user_params)
    end
  rescue ActiveRecord::RecordInvalid => e
    # Handle the error, e.g., log it or re-raise it
    raise e
  end

  private

  # Validates the presence and uniqueness of tenant name and user email.
  # Also validates the format of the user email.
  #
  # @raise [ActiveRecord::RecordInvalid] if any validation fails.
  def validate_params!
    if @tenant_params[:name].blank?
      raise ActiveRecord::RecordInvalid.new(Tenant.new), "Tenant name can't be blank"
    end

    if @user_params[:email].blank?
      raise ActiveRecord::RecordInvalid.new(User.new), "User email can't be blank"
    end

    if Tenant.exists?(name: @tenant_params[:name])
      raise ActiveRecord::RecordInvalid.new(Tenant.new), "Tenant name already exists"
    end

    if User.exists?(email: @user_params[:email])
      raise ActiveRecord::RecordInvalid.new(User.new), "User email already exists"
    end

    unless @user_params[:email] =~ URI::MailTo::EMAIL_REGEXP
      raise ActiveRecord::RecordInvalid.new(User.new), "User email format is invalid"
    end
  end
end