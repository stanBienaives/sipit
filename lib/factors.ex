defmodule Factors do
  def decompose( n ) do
    Primes.start
    Primes.all_below( n )
    |> Enum.filter( &( rem(n,&1) == 0 ) )
  end
end
