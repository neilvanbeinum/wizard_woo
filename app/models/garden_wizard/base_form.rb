module GardenWizard
  class BaseForm
    include ActiveModel::Model

    # Writing as well as reading necessary for the controller to assign params to this
    attr_accessor :garden

    # The Splat operator, in this context, converts the array into positional arguments to 'delegate'
    # This is useful when you want to pass in several parameters to a method, but you don't know in advance how many there will be
    delegate *Garden.attribute_names.map { |attr| [attr, "#{attr}="] }.flatten, to: :garden

    def initialize(garden_attributes = {})
      @garden = Garden.new(garden_attributes)
    end
  end
end
