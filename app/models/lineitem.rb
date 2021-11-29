class Lineitem < ApplicationRecord
  belongs_to :invoice
  belongs_to :person
  has_many :sittings
end
