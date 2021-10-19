class Offer < ApplicationRecord
    validates :description, :value, :hours, :finish_date, presence: true

    belongs_to :plan
    belongs_to :professional
    enum status: {oferecida: 0, aceita: 1, recusada: 2}
  
    def accept
        self.status = "aceita"
        self.save
    end

    def refuse
        self.status = "recusada"
        self.save
    end

end
