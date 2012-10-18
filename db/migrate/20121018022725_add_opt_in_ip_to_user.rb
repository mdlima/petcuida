class AddOptInIpToUser < ActiveRecord::Migration
  def change
    add_column :users, :opt_in_ip, :string
  end
end
