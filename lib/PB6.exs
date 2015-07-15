defmodule PB6 do
  
  def difference_sqr_sum(n) do
    { sum, sum_sqr } = (1..n) |> Enum.reduce( { 0 , 0 }, fn( i , {  sum, sum_sqr } ) -> { sum + i, sum_sqr + i*i } end )
    sum*sum - sum_sqr
  end
end

Report.time( PB6, :difference_sqr_sum, [100] )

#REP: 25164150 
