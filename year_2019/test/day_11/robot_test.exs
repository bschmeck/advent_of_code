defmodule Day11.RobotTest do
  use ExUnit.Case

  test "it moves left" do
    robot = %Day11.Robot{}
    robot = Day11.Robot.move(robot, :left)
    assert robot.location == {-1, 0}
    robot = Day11.Robot.move(robot, :left)
    assert robot.location == {-1, -1}
    robot = Day11.Robot.move(robot, :left)
    assert robot.location == {0, -1}
    robot = Day11.Robot.move(robot, :left)
    assert robot.location == {0, 0}
  end

  test "it moves right" do
    robot = %Day11.Robot{}
    robot = Day11.Robot.move(robot, :right)
    assert robot.location == {1, 0}
    robot = Day11.Robot.move(robot, :right)
    assert robot.location == {1, -1}
    robot = Day11.Robot.move(robot, :right)
    assert robot.location == {0, -1}
    robot = Day11.Robot.move(robot, :right)
    assert robot.location == {0, 0}
  end
end
