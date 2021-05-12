defmodule FriendsApp.CLI.Main do
  alias Mix.Shell.IO, as: Shell

  def start_app do
    Shell.cmd("clear")
    welcome_message()
    Shell.prompt("Press enter to continue...")
  end

  def welcome_message do
    Shell.info("========= Friends App ==========")
    Shell.info("| Seja bem-vindo a sua agenda! |")
    Shell.info("================================")
  end
end
