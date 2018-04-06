class AddDisabledColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :drivers, :disabled, :boolean, default: false
    add_column :passengers, :disabled, :boolean, default: false
  end
end
