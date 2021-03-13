class DropJwtDenlyList < ActiveRecord::Migration[6.1]
  def change
    drop_table :jwt_denylists
  end
end
