class CreateOffers < ActiveRecord::Migration[6.1]
  def change
    create_table :offers do |t|
      t.text :description
      t.decimal :value
      t.integer :hours
      t.date :finish_date
      t.integer :status, default: 0
      t.belongs_to :professional, foreign_key: true
      t.belongs_to :plan, foreign_key: true
      t.timestamps
    end
  end
end
