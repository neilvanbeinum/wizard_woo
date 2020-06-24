# frozen_string_literal: true

module GardenWizard
  class FlowersForm < BaseForm
    validates :flowers, presence: true
  end
end
