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

  def primes_to( max) do
    sqrt = Float.ceil( :math.sqrt(max) ) |> round
    Enum.to_list(2..max) |> do_primes([] , sqrt)
  end

  defp do_primes([ candidate | rest ], primes, sqrt) when (candidate > sqrt),do: Enum.reverse(primes) ++ [ candidate | rest ]
  defp do_primes([ candidate | rest ], primes, sqrt) do
    candidates = Enum.reject(rest, &(rem(&1, candidate) == 0))
    do_primes(candidates, [ candidate | primes ], sqrt)
  end

  def stream do
    primes = Agent.get(__MODULE__, &(&1))
    #Stream.unfold( primes, &_next_prime/1 )
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


  @doc " slicly modified implementation of Erathostemne algortithm using Set"
  def all_below(max) do

    # should use the Erathostemne algorithm
    sqrt = Float.ceil( :math.sqrt(max) ) |> round

    non_primes = (2..sqrt)
    |> Enum.reduce( HashSet.new , fn n, set ->
          Set.union( set,  multiples( n, max ) )
        end)

    naturals = (2..max) |> Enum.into( HashSet.new ) 
    Set.difference( naturals , non_primes )
    |> Set.to_list
    |> Enum.sort

  end

  defp multiples( n , max ) do
    Stream.iterate( 2*n , &( &1+n ) )
    |> Enum.take_while( &( &1 <= max) )
    |> Enum.into( HashSet.new )
  end


    


  @doc " DO NOT USE: my attempt to use sieves"
  def all_below_sieve_method(max) do
    
    # should use the Erathostemne algorithm
    sqrt = Float.ceil( :math.sqrt(max) ) |> round

    sieves = for x <- (2..max), do: true

    # use zip
    #Enum.zip( (2..max),  build_sieves( 2, sqrt , sieves ) )
    #|> Enum.filter( fn { _, bool } -> bool end )
    #|> Enum.map( fn { n, true} -> n end )
    # reccursive strategie to get 
    build_sieves( 2, sqrt , sieves )

  end


  def build_sieves( _n , _max, [] ),do: [] 
  def build_sieves( n, max, current_sieves ) when n > max do
    IO.puts "finished #{n}"
    current_sieves
  end
  def build_sieves( n , max, current_sieves = [h|t]) when not h do
     IO.puts "Skip #{n}"
    [h | build_sieves( n+1, max, t ) ]
  end
  def build_sieves( n, max, current_sieves = [h|t] ) do
    [ h1 | t1 ] = merge_sieves( flag_multiple( n, length( current_sieves ) + n - 1 ), current_sieves )
    [ h1 | build_sieves( n+1, max, t1 ) ]
  end


  def flag_multiple( n , max ) do
    for m <- (2..max), m >= n,do: ( m == n || rem(m,n)!= 0 )
  end

  def merge_sieves( [],[] ), do: []
  def merge_sieves( [h1|t1], [h2|t2] ), do: [ h1 && h2 | merge_sieves(t1,t2) ]

end
