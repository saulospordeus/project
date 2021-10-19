class Plan < ApplicationRecord
    validates :title, :value, :description, :limit_date, presence: true
    
#    scope :accepted, -> { where(status: 'accepted') }
  #  scope :from_professional, -> {where(professional: professional)}

    belongs_to :user
    has_many :offers, dependent: :destroy
    has_many :professionals, through: :offers
    enum status: {aberto: 0, fechado: 1}
    
    def close
        self.status = "fechado"
        self.save
    end
    
    def open
        self.status = "aberto"
        self.save
    end
end
