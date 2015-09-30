defmodule PB12 do
  def resolve(n) do

    Stream.iterate( 1 , &(&1+1) ) 
    #|> Stream.map( &(div(&1*(&1+1),2)) )
    |> Stream.map( fn i ->
      l = Factors.decompose_all( i+1 ) ++ Factors.decompose_all( i)  -- [2]
      |> length
      #IO.inspect { i , l } 
      { i , l }
    end)
    |> Enum.take_while( fn { i , l } -> (l < n) end )
    |> Enum.max_by( fn { i , l } -> l end )
  end

  def sum(n), do: div(n*n+1,2)
end


# decompose n et n+1

# intersection des suites: 
# - n * ( n +1 ) /2 ( numbres triangulaires )
# - produit scalaire du vecteur de longueur 500, contenant 
# de valeurs [ 0 - 500 ] tels que sum == 500
# => [ 0 - 9 ]{500} scalaire [  , tel que sum == 500
# [ 

 



Primes.start
Primes.all_below( 100_000 )
Report.time( PB12, :resolve, [500] )
