class AddClientInfosSigfoxToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :client_id, :string
    add_column :users, :client_secret, :string
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
  end
end
