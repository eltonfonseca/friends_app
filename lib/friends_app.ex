defmodule FriendsApp do
  def hello do
    :world
  end

  def my_environment do
    case Mix.env() do
      :prod -> "Production Environment"
      :dev -> "Development Environment"
      :test -> "Test Environment"
    end
  end
end
