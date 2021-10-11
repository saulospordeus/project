class AddReferenceToProfile < ActiveRecord::Migration[6.1]
  def change
    add_reference :profiles, :professional, foreign_key: true
  end
end
