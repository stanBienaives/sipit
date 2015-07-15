defmodule PB7 do
  def nth_primes( n ) do
    Primes.start # should be in the mix config
    Primes.stream |> Enum.at( n )
  end
end


Report.time PB7, :nth_primes, [10001]
#REP: 104033

