class Offer < ApplicationRecord
    validates :description, :value, :hours, :finish_date, presence: true
    
    belongs_to :plan
    belongs_to :professional
    enum status: {offered: 0, accepted: 1, refused: 2}
  
    def accept
        self.status = "accepted"
        self.save
    end

    def refuse
        self.status = "refused"
        self.save
    end

end
