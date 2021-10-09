class AddPresenceTypeToPlan < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :presence_type, :string
  end
end
