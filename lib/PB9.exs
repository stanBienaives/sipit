#A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

#a2 + b2 = c2
#For example, 32 + 42 = 9 + 16 = 25 = 52.

#There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#Find the product abc.

defmodule PB9 do
  def resolve_brute_force(n) do

    triplet = for c <- (1..n), b <- (1..n), a <- (1..n), a < b , b < c,(a+b+c)==n,(a*a+b*b)==c*c, do: a*b*c
    hd( triplet )
  end


  def resolve do
    { a, b, c } = Stream.iterate(1,&(&1+1))
    |> Stream.flat_map( &square_decompose/1 )
    |> Enum.find( fn { a,b,c } -> (a + b + c) == 1000  end)
    a*b*c
  end

  def square_decompose(c) do
    # (n-k)^2 >= n2/2
    k = Float.floor( c / :math.sqrt(2) ) |> round
    (k..c-1)
    |> Enum.filter( &( is_square(c*c - &1*&1) ) )
    |> Enum.map( fn b ->
        a = :math.sqrt( c*c - b*b ) |> round
        {a, b , c }
      end)
  end

  def is_square( n )  do
    :math.sqrt(n) == Float.floor( :math.sqrt(n) )
  end
end

#Report.time( PB9, :resolve_brute_force, [ 1000 ])
# This is higly inneficient... a trick must be found...
Report.time( PB9, :resolve, [])

#REP: 31875000
