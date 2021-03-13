class DropDropUsers < ActiveRecord::Migration[6.1]
  def change
    drop_table :drop_users
  end
end
