# frozen_string_literal: true

module GardenWizard
  class BirdsForm < BaseForm
    validates :birds, presence: true
  end
end
