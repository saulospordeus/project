class AddReferencesToProfessionalfeedback < ActiveRecord::Migration[6.1]
  def change
    add_reference :professionalfeedbacks, :professional, foreign_key: true
    add_reference :professionalfeedbacks, :user, foreign_key: true
  end
end
