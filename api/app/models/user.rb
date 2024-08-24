# app/models/user.rb

# The User model represents a user in the application.
class User < ApplicationRecord
    include MultitenancyModule
  
    # Associations
    belongs_to :tenant
    
    # Secure password handling
    has_secure_password
  
    # Validations
    validates :email, presence: true, uniqueness: { scope: :tenant_id }
    validates :password, presence: true, length: { minimum: 6 }
  
    # Multitenancy setup
    multitenant :tenant
  end