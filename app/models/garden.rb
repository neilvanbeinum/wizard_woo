class Garden < ApplicationRecord
  validates :flowers, presence: true
  validates :birds, presence: true
  validates :path, presence: true
end
