defmodule FriendsApp.CLI.Menu.Choice do
  alias Mix.Shell.IO, as: Shell
  alias FriendsApp.CLI.Menu.Items

  def start do
    Shell.cmd("clear")
    Shell.info("Escolha uma opção:")

    menu_itens = Items.all()
    find_menu_item_by_index = &Enum.at(menu_itens, &1, :error)

    menu_itens
    |> Enum.map(&(&1.label))
    |> display_options()
    |> generate_question()
    |> Shell.prompt()
    |> parse_answer()
    |> find_menu_item_by_index.()
    |> validate_menu_item()
    |> confirm_message()
  end

  defp display_options(options) do
    options
    |> Enum.with_index(1)
    |> Enum.each(fn {option, index} ->
      Shell.info("#{index} - #{option}")
    end)

    options
  end

  defp generate_question(options) do
    options = Enum.join(1..Enum.count(options), ",")
    "Escolha uma opção: [#{options}]\n"
  end

  defp parse_answer(answer) do
    case Integer.parse(answer) do
      :error -> invalid_option()
      {option, _} -> option - 1
    end
  end

  defp validate_menu_item(chosen_menu_item) do
    case chosen_menu_item do
      :error -> invalid_option()
      _ -> chosen_menu_item
    end
  end

  defp confirm_message(chosen_menu_item) do
    Shell.cmd("clear")
    Shell.info("Você escolheu a opção: #{chosen_menu_item.label}")

    if Shell.yes?("Confirma?") do
      Shell.info("... #{chosen_menu_item.label} ...")
    else
      start()
    end
  end

  defp invalid_option() do
    Shell.cmd("clear")
    Shell.error("Opção inválida")
    Shell.prompt("Pressione Enter para tentar novamente ...")

    start()
  end
end