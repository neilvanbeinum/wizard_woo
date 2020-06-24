class HomeController < ApplicationController
  def index
    @garden_count = Garden.count
  end
end
