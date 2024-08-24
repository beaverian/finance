# app/models/tenant.rb

# The Tenant model represents a tenant in the application.
class Tenant < ApplicationRecord
    # Associations
    has_many :users, dependent: :destroy
  
    # Validations
    validates :name, presence: true, uniqueness: true
  end