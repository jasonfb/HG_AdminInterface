class Invoice < ApplicationRecord

  belongs_to :person
  has_many :lineitems

end
