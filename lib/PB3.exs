# Largest Prime factor
# the prime factor of 13195 are 5,7,13,29
# what is the Largest prime factor of the number 600851475143


defmodule PB3 do

  # solution 1
  def bpd( n ), do: bpd( n, 0, 2)
  def bpd( n, bpd, inc ) when rem( n, inc ) == 0, do: bpd( div(n,inc), inc, inc )
  def bpd( n, bpd, inc ) when n <= bpd, do: bpd
  def bpd( n, bpd, inc ) do
    #bpd n, bpd, inc + 1
    bpd n, bpd, inc + (if inc == 2, do: 1, else: 2)
  end


  #solution 2- faster when largest_prime is close to the targetted number
  def largest_prime( n ), do: _largest_prime( n, [2] )
  def _largest_prime( n, [ n | _tail ] ), do: n
  def _largest_prime( n, primes = [ head | _tail ] )
  when rem( n, head ) == 0,
  do: _largest_prime( div(n, head ) , primes )

  def _largest_prime( n , primes = [ head | _tail ] )
  when  n <= head * head,
  do: n

  def _largest_prime( n, primes ),
  do: _largest_prime( n ,  next_prime( primes ) )

  #def next_prime( []), do: next_prime([2])
  def next_prime( primes = [ head | _tail ] ) do
    Enum.reverse(primes)
    |> next_prime(head + 1)
  end

  def next_prime( ordered_primes = [ head | tail ], buffer) do
    if is_prime?( buffer, ordered_primes  ) do
      [ buffer | Enum.reverse(ordered_primes) ]
    else
      next_prime( ordered_primes, buffer + 1 )
    end
  end

  defp is_prime?( n, [] ), do: true
  defp is_prime?( n, _primes = [ head | tail ] ) when rem(n,head) == 0, do: false
  defp is_prime?( n, _primes = [ head | tail ] ) do
    #IO.puts inspect _primes
    is_prime?( n, tail )
  end
end


#PB3.largest_prime( 10 ) |> IO.puts
:timer.tc( PB3, :largest_prime, [ 600851475143 ]) |> IO.inspect
:timer.tc( PB3, :bpd, [ 600851475143 ]) |> IO.inspect
IO.puts "##############"
:timer.tc( PB3, :largest_prime, [ 131853 ]) |> IO.inspect
:timer.tc( PB3, :bpd, [ 131853 ]) |> IO.inspect
IO.puts "##############"
:timer.tc( PB3, :largest_prime, [ 43951 ]) |> IO.inspect
:timer.tc( PB3, :bpd, [ 43951 ]) |> IO.inspect
IO.puts "##############"
:timer.tc( PB3, :largest_prime, [ 60085147514345 ]) |> IO.inspect
:timer.tc( PB3, :bpd, [ 60085147514345 ]) |> IO.inspect
IO.puts "##############"
:timer.tc( PB3, :largest_prime, [ 580331 ]) |> IO.inspect
:timer.tc( PB3, :bpd, [ 580331 ]) |> IO.inspect
