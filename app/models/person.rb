class Person < ApplicationRecord
  belongs_to :account
  has_many :lineitem
end
