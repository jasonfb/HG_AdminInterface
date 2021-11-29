class Sitting < ApplicationRecord
  belongs_to :lineitem
  belongs_to :service
end
