class Profile < ApplicationRecord
    belongs_to :professional
    validates :name, :social_name, :background, :description, :area, presence: true
end