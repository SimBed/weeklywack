class WorkoutsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :create, :update, :destroy]
  before_action :set_workout, only: [:edit, :update, :destroy]
  #before_action :admin_user, only: :destroy

  def index
    #@workouts = Workout.paginate(page: params[:page])
    @workouts = Workout.all.order(sort_column + " " + sort_direction, :name).paginate(page: params[:page],per_page: 10)
  end

  def new
    @workout = Workout.new
  end

  def create
    @workout = Workout.new(workout_params)

      if @workout.save
        redirect_to workouts_path
        flash[:success] = "New workout, #{@workout.name} added!"
      else
       render :new
      end
  end

  def edit
  end

  def update
      if @workout.update(workout_params)
        redirect_to workouts_path
        flash[:success] = "#{@workout.name} updated"
      else
        render :edit
      end
  end

  def destroy
    @workout.destroy
    flash[:success] = "#{@workout.name} deleted"
    redirect_to workouts_path
  end
end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def workout_params
    params.require(:workout).permit(:name, :style, :url, :length, :intensity)
  end

  def set_workout
    @workout = Workout.find(params[:id])
  end

  def sort_column
    #params[:sort] || "name"
    Workout.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    #params[:direction] || "asc"
    #additional code provides robust sanitisation of what goes into the order clause
    %w[asc desc].include?(params[:direction]) ? params[:direction]  : "asc"
  end