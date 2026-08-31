require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "requires a name" do
    task = Task.new(user: users(:one))

    assert_not task.valid?
    assert_includes task.errors[:name], "can't be blank"
  end

  test "requires a user" do
    task = Task.new(name: "Buy milk")

    assert_not task.valid?
    assert_includes task.errors[:user], "can't be blank"
  end

  test "defaults completed to false" do
    task = users(:one).tasks.create!(name: "Buy milk")

    assert_equal false, task.completed
  end
end