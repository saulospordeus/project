class Plan < ApplicationRecord
    validates :title, :value, :description, :limit_date, presence: true

    belongs_to :user
    has_many :offers, dependent: :destroy
    has_many :professionals, through: :offers
    enum status: {open: 0, closed: 1}
    
    def close
        self.status = "closed"
        self.save
    end
    
    def open
        self.status = "open"
        self.save
    end
end
