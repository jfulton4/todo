require 'test_helper'

class TasksControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  setup do
    @user = users(:one)
    @other_user = users(:two)

    sign_in @user
  end

  test "redirects signed-out users to login" do
    sign_out @user

    get :index

    assert_redirected_to new_user_session_path
  end

  test "creates a task for the current user" do
    assert_difference('@user.tasks.count', 1) do
      post :create, task: {
        name: "Study controller tests",
        completed: false
      }
    end

    assert_redirected_to tasks_path
    assert_equal @user, Task.order(:created_at).last.user
  end

  test "does not update another users task" do
    other_task = tasks(:two)

    assert_raises(ActiveRecord::RecordNotFound) do
      patch :update,
            id: other_task.id,
            task: { completed: true }
    end

    assert_not other_task.reload.completed
  end

  test "does not delete another users task" do
    other_task = tasks(:two)

    assert_no_difference('Task.count') do
      assert_raises(ActiveRecord::RecordNotFound) do
        delete :destroy, id: other_task.id
      end
    end
  end

  test "index only loads the current users tasks" do
    get :index

    assert_includes assigns(:tasks), tasks(:one)
    assert_not_includes assigns(:tasks), tasks(:two)
  end

  test "cannot assign a task to another user" do
    post :create, task: {
      name: "Injected ownership",
      completed: false,
      user_id: @other_user.id
    }

    created_task = Task.order(:id).last
    assert_equal @user, created_task.user
  end
end