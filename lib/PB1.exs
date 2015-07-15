#if we list all natural number below 10 that are multiples of 3 or 5, we get 3,5,6 and 9. The sum of all those numbers is 23.
# find the sum of all the multiples of 3 or 5 between 1000
defmodule PB1 do
  def sum( max_number ) do
    (1..max_number) |> Enum.to_list |> _sum 0
  end

  def _sum( []              , acc ), do: acc
  def _sum( [ head  | tail ], acc ) when rem( head, 3) == 0, do:  _sum( tail, acc + head )
  def _sum( [ head  | tail ], acc ) when rem( head, 5) == 0, do:  _sum( tail, acc + head )
  def _sum( [ _head | tail ], acc ), do: _sum( tail, acc)

end

PB1.sum(1000) |> IO.puts

Report.time( PB1, :sum, [1000] )


#REP: 234168
