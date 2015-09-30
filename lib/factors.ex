defmodule Factors do
  def decompose( n ) do
    Primes.start
    Primes.all_below( n )
    |> Enum.filter( &( rem(n,&1) == 0 ) )
    |> Enum.sort
  end


  def decompose_all( n ) do
    Primes.start
    Primes.all_below( n )
    |> Enum.flat_map( fn prime ->
      Stream.iterate( prime, fn multiple -> multiple + prime end)
      # Stream.iterate( prime, fn multiple -> multiple + multiple end)
      |> Stream.take_while( &(&1 <= n ))
      |> Enum.filter( &( rem( n, &1 ) == 0 ) )
    end)
    |> Enum.uniq
    |> Enum.sort
  end
end
