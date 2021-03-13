class CreateDropUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :drop_users do |t|
      drop_table :users
      t.timestamps
    end
  end
end
