class AddSubdomainToTenants < ActiveRecord::Migration[7.2]
  def change
    add_column :tenants, :subdomain, :string
  end
end
