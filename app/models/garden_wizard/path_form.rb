# frozen_string_literal: true

module GardenWizard
  class PathForm < BaseForm
    validates :path, presence: true
  end
end
