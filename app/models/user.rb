class User < ApplicationRecord
    belongs_to :tenant
    multitenant :tenant_id
end
