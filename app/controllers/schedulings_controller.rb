class SchedulingsController < ApplicationController
  before_action :logged_in_as_real_user, only: [:create, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:show]
  before_action :set_scheduling, only: [:show, :edit, :update, :destroy]
  require 'cgi'
  def index
    @schedulings = current_user.schedulings.order_by_start_time
    @scheduling = current_user.schedulings.build()
    session[:linked_from] = :schedulings_index
  end

  def show
    unless @scheduling.workout_id.nil?
      @workout = Workout.find(@scheduling.workout_id)
      @microposts = @workout.microposts.paginate(page: params[:page])
      @micropost = current_user.microposts.build()
    end
    session[:wk_url] = params[:wk_url]
    # || session[:wk_url]
  end

  def create
    @scheduling = current_user.schedulings.build(scheduling_params)
    # a scheduling can be created from 2 places:
    # 1. from the Workouts index page, in which case the name of the scheduling
    # is set as the same name as the corresponding workout [update: the workout's short name]
    # (the name can not be edited on the form and workout_id is a hidden field in the form)
    # 2. from the Schedulings index, in which case the user can give the scheduling any name and workout_id is nil
    # name_for_cal returns the short name for the Workout if there is one (defined in workouts model)
    @scheduling.name ||= Workout.find(params[:workout_id]).name_for_cal
    # ||= instead of = so tests dont fail
    @scheduling.workout_id ||= params[:workout_id]
    if @scheduling.save
      # the js.erb needs to know whether the form submission came from the scheduling or workout index as the calendars are shown differently in each place (bi-weekly/monthly)
      @days_display = session[:linked_from] == "schedulings_index" ? 28 : 14
      #@days_display = params[:form_setting] == "sch_index" ? 28 : 14
      @wk_url = params[:wk_url]
      # see application controller - session_workout_names method not used
      # byebug
      # reverse the JSON-isation from the index controller neeeded to store an array in a cookie
      @workout_names = JSON.parse session[:workout_names] if session[:workout_names]
      @schedulings = current_user.schedulings.order_by_start_time
      #@temp = @workout_names.map { |e| e.downcase.split.join.downcase + '_cal' }
      respond_to do |format|
         format.html { flash[:success] = "#{@scheduling.name} scheduled!"
                       redirect_to request.referrer }
         format.js { flash.now[:success] = "#{@scheduling.name} scheduled!" }
       end

      # redirect_to workouts_path or schedulings_path depending which URL the post was from pre-AJAX
      # redirect_to request.referrer
      # flash[:success] = "#{@scheduling.name} scheduled!"
    else
      if @scheduling.workout_id.nil?
          redirect_to root_url
      else
        @workout = Workout.find(@scheduling.workout_id)
        @attempts = @workout.attempts.paginate(page: params[:page])
        @microposts = @workout.microposts.paginate(page: params[:page])
        @micropost = current_user.microposts.build()

        render 'workouts/show'
      end
    end
  end

  def edit
  end

  def update
    if @scheduling.update_attributes(scheduling_params)
      flash[:success] = "Scheduling updated"
      redirect_to @scheduling
    else
      render 'edit'
    end
  end

  def destroy
     @scheduling.destroy
     @schedulings = current_user.schedulings.order_by_start_time
     respond_to do |format|
        format.html { flash[:success] = "Scheduling deleted"
                      redirect_to schedulings_path }
        format.js { flash.now[:success] = "#{@scheduling.name} deleted" }
      end
   end

  private

    def scheduling_params
      params.require(:scheduling).permit(:name, :start_time, :workout_id)
    end

    # Before filte:start_timers
    def set_scheduling
      @scheduling = Scheduling.find(params[:id])
      @user = User.find(@scheduling.user_id)
      # can't have users interfering with other users schedulings
      unless current_user?(@user)
            flash[:danger] = "No access."
            redirect_to(root_url)
      end
    end

    # not used
    def correct_user_or_admin
      redirect_to(root_url) unless (current_user?(@scheduling.user) or (current_user && current_user.admin?))
    end

end