class Plan < ApplicationRecord
    validates :title, :value, :description, :limit_date, presence: true

    belongs_to :user
    has_many :offers
    has_many :professionals, through: :offers

    #def search(value)
    #searched_plans == Plan.select { |obj| obj.attr == 'value'}
    #end
end
