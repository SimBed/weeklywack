require 'test_helper'

class WorkoutsCreateTest < ActionDispatch::IntegrationTest

  test "invalid input for new workout" do
    assert_no_difference 'Workout.count' do
      post workouts_path, params: { workout: { name:  "",
                                         url: "wwwinvalid",
                                         style: "Yoga",
                                         length: "75",
                                         intensity: "High" } }
    end
    assert_template 'workouts/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid input for new workout" do
    assert_difference 'Workout.count', 1 do
      post workouts_path, params: { workout: { name:  "testworkout",
                                         url: "www.testvalid.com",
                                         style: "Yoga",
                                         length: "75",
                                         intensity: "High" }  }
    end
    follow_redirect!
    assert_template 'workouts/index'
    assert_not flash.empty?
  end

end
