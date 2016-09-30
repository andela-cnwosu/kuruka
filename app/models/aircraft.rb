# frozen_string_literal: true
class Aircraft < ApplicationRecord
  has_many :flights
end
