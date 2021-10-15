class Plan < ApplicationRecord
    validates :title, :value, :description, :limit_date, presence: true

    belongs_to :user
    has_many :offers
    has_many :professionals, through: :offers
    enum status: {open: 0, closed: 1, refused: 2}
    def close
        self.status = "closed"
        self.save
    end

end
