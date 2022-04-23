defmodule Mos.Identifiers do
  @doc "This module generates identifiers for publicly visible records"
  
  def mixed_alphabet do
    to_string(Enum.to_list(?a .. ?z) ++ Enum.to_list(?A .. ?Z))
  end

  @doc "Returns a new identifier with a mixed alphabet (lower, uppercase)"
  def find_new_mixed_identifier() do
    find_new_identifier(mixed_alphabet())
  end
  
  def find_new_identifier(alphabet) do
    converter = fn _, acc ->
      idx = :rand.uniform(String.length(alphabet)) 

      acc <> String.at(alphabet, idx - 1)
    end

    Enum.reduce(1 .. 50, "", converter)
  end
end
