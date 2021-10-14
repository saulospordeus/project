class CreateProfessionalfeedbacks < ActiveRecord::Migration[6.1]
  def change
    create_table :professionalfeedbacks do |t|
      t.text :text
      t.integer :rate
      t.belongs_to :professional, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end
  end
end
