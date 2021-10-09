class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :title
      t.text :description
      t.text :hability
      t.decimal :value
      t.date :limit_date

      t.timestamps
    end
  end
end
