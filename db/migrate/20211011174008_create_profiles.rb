class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :social_name
      t.string :background
      t.string :description
      t.string :area

      t.timestamps
    end
  end
end
