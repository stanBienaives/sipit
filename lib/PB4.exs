defmodule PB4 do

  def biggest_palindrome do
    products = for i <- (100..999), j <- (100..999), i >= j, do: i*j
    products |> Enum.sort |> Enum.reverse |> Enum.find( &is_palindrome/1 )
  end

  # NOT WORKING... needs to find a better path than the stupid line to line scan
  def biggest_palindrome_stream do
    { p, q } =Stream.iterate( {999,999}, &next_box/1) |> Enum.find( fn { p, q} -> is_palindrome( p*q ) end)
    p*q
  end

  def next_box( {p,p}  ),  do: {p-1,999}
  def next_box( {p,100}), do: {p-1,999}
  def next_box( {p,q} ), do: {p,q-1}



  def is_palindrome( n ) do
    text = to_string n
    String.reverse( text ) == text
  end
end

Report.time( PB4, :biggest_palindrome, [])
Report.time( PB4, :biggest_palindrome_stream, [])



