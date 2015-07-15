defmodule PB5 do

  def evenly_divisible(n) do
    (1..n)
    |> Enum.map( &Factors.decompose/1 )
    |> Enum.map( &Enum.uniq/1 )
    |> Enum.filter( &( length(&1) == 1 ) )
    |> Enum.map( &List.first/1 )
    |> Enum.reduce( 1, fn(x, acc) -> x*acc end)
  end
end

Report.time( PB5, :evenly_divisible, [20] )
#REP: 232792560


