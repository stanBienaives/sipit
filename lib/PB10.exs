defmodule PB10 do
  def resolve do
    Primes.up_to(2_000_000)
    |> Enum.reverse
    |> Enum.reduce( &(&1 + &2) )
  end
end


Report.time( PB10, :resolve, [])

#REP: 142913828922
