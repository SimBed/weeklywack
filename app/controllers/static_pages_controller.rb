class StaticPagesController < ApplicationController
  def home
    @workouts = Workout.all.order("created_at desc")
  end

end
