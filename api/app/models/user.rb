# app/models/user.rb

# The User model represents a user in the application.
class User < ApplicationRecord
    include MultitenancyModule
  
    # Secure password handling
    has_secure_password

    # Associations
    belongs_to :tenant
    
    # Secure password handling
    has_secure_password
  
    # Validations
    validates :email, presence: true, uniqueness: { scope: :tenant_id }
    validates :password, presence: true, length: { minimum: 6 }
  
    # Multitenancy setup
    multitenant :tenant

    # Generates a JWT token for the user.
    # The token is generated with the user's ID and an expiration time of 60 days.
    #
    # @return [String] JWT token
    def generate_jwt
      JWT.encode({ id: id, exp: 60.days.from_now.to_i }, Rails.application.credentials.secret_key_base)
    end
  end