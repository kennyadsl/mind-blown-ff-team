defmodule MindBlownTeam do
  @initial_team %{
    goalkeepers: %{
      starters: [
        'REINA'
      ],
      banching: [
        'POSAVEC'
      ]
    },

    defenders: %{
      starters: [
        'ALBIOL',
        'RUDIGER',
        'WIDMER',
      ],
      banching: [
        'GOBBI',
        'IZZO',
      ]
    },

    midfielders: %{
      starters: [
        'BANEGA',
        'BENASSI',
        'JOAO PEDRO',
        'DZEMAILI',
      ],
      banching: [
        'D\'ALESSANDRO',
        'NAGY',
      ]
    },
    strikers: %{
      starters: [
        'SALAH',
        'ICARDI',
        'KEITA B',
      ],
      banching: [
        'QUAGLIARELLA',
        'MEGGIORINI',
      ]
    }
  }


  # MindBlownTeam.print_team
  # MindBlownTeam.print_team(team)
  def print_team(team \\ @initial_team) do
    IO.inspect team
    team
  end


  # ----- First attempt with Elixir

  # MindBlownTeam.shake
  def shake(team \\ @initial_team, i \\ 40)
  def shake(team, i) when i == 40 do
    team
      |> print_team
      |> shake(i - 1)
  end
  def shake(team, i) when i == 0 do
    team
      |> print_team
  end
  def shake(team, i) do
    unit = find_random_unit()
    team
      |> Map.put(unit, shake_unit(team, unit))
      |> shake(i - 1)
  end

  def find_random_unit do
    [:goalkeepers, :defenders, :midfielders, :strikers] |> Enum.random
  end

  def shake_unit(team, unit) do
    starter_player = team[unit][:starters] |> Enum.random
    banching_player = team[unit][:banching] |> Enum.random

    IO.puts "Change: #{banching_player} from banching, #{starter_player} will start"

    team[unit]
      |> Map.put(:starters, replace(team[unit][:starters], starter_player, banching_player))
      |> Map.put(:banching, replace(team[unit][:banching], banching_player, starter_player))
  end

  # Replace a player from a list with another player
  def replace(list, player, new_player) do
    List.replace_at(list, player_index(player, list), new_player)
  end

  # Return the index of a player from a list of players
  def player_index(player, list) do
    Enum.find_index(list, fn(player_name) -> player_name == player end)
  end
end
