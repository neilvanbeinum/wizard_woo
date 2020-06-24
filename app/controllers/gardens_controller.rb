# frozen_string_literal: true

class GardensController < ApplicationController
  WIZARD_STEPS = %w[ flowers birds path ].freeze

  def flowers
    # Instantiate a new form model for this step, passing in a new garden as the basis
    @garden_form = GardenWizard::FlowersForm.new(session[:garden_params])
  end

  def birds
    @garden_form = GardenWizard::BirdsForm.new(session[:garden_params])
  end

  def path
    @garden_form = GardenWizard::PathForm.new(session[:garden_params])
  end

  def validate_step
    # Build a form model, purely for validation purposes, based off all attributes saved from previous steps
    # (Or nil if the first step)
    current_step_name = params[:current_step]  # e.g. 'flowers'

    case current_step_name
    when "flowers"
      garden_form_class = GardenWizard::FlowersForm
    when "birds"
      garden_form_class = GardenWizard::BirdsForm
    else
      garden_form_class = GardenWizard::PathForm
    end

    @garden_form = garden_form_class.new(session[:garden_params])

    # Populate the model underlying the form model with the latest, additional parameters
    # These shouldn't clash with any existing attributes set on the model, as those should have come from previous steps and therefore
    # were for different attribute names
    @garden_form.garden.attributes = garden_params

    # Store every attribute, including those just submitted, in the wizard in the session
    session[:garden_params] = @garden_form.garden.attributes

    # Requires each form view to have a hidden field for this
    next_step_name = get_next_step(current_step_name)

    if @garden_form.valid?
      if next_step_name
        redirect_to action: next_step_name
      else
        create
        return
      end
    else
      render current_step_name
    end
  end

  def create
    if @garden_form.garden.save
      session[:garden_params] = nil
      redirect_to root_path
    else
      render WIZARD_STEPS.first
    end
  end

  private

  # Rails detects params from sources including POST parameters and query parameters
  # It puts them into a hash-like object, params
  def garden_params
    params.require(:garden_form).permit(:flowers, :birds, :path)
  end

  def get_next_step(current_step_name)
    WIZARD_STEPS[WIZARD_STEPS.index(current_step_name) + 1]
  end
end
