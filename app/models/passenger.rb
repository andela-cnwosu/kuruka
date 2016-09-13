class Passenger < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :booking, optional: true
  belongs_to :airfare

  validates :phone,
            length: { minimum: 10 },
            on: :create

  validates :first_name,
            :last_name,
            :airfare,
            presence: true,
            allow_nil: false
end
