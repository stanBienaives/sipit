defmodule Primes do

  def start do
    Agent.start_link fn -> [] end, name: __MODULE__
  end

  def stop do
    Agent.stop __MODULE__
  end

  def next_prime do
    Agent.get_and_update( __MODULE__, __MODULE__, :_next_prime,[])
  end

  def all_below(max) do
    stream
    |> Enum.take_while( fn p -> p <= max end )
  end

  def stream do
    primes = Agent.get(__MODULE__, &(&1))
    stream = Stream.repeatedly( &next_prime/0 )
    Stream.concat( Enum.reverse(primes), stream )
  end

  def _next_prime( [] ), do: { 2, [2] }
  def _next_prime( primes = [ h | _t ] ) do
    next = primes
    |> Enum.reverse
    |> Enum.take_while( &(&1*&1 <= h ) )
    |> _next_prime( ( if  h==2, do: 3, else: h+2) )

    { next , [ next | primes ] }
  end

  def _next_prime( relevant_primes , buffer ) do
    if Enum.any?( relevant_primes, fn  p -> rem( buffer,p) == 0 end)  do
      inc = if buffer==2 , do: 3, else: buffer+2
      _next_prime relevant_primes, inc
    else
      buffer
    end
  end

end
