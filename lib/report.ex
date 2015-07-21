defmodule Report do

  def time( module, func, args ) do
    header module
    :timer.tc( module, func , args )
    |> _report

    footer
  end


  def header( module ) do
    exercice = module |> to_string
    exercice = Regex.scan( ~r{([0-9]+)}, exercice )|> hd |> List.last

    IO.puts """

    ---------------------------
      Exercice n° #{exercice}
    ---------------------------
    """
  end


  def footer do
    IO.puts ""
  end

  def _report( { time, result } ) do
    IO.puts "Result is #{inspect result}"
    IO.puts "Took #{time/1000}ms"
  end
end
