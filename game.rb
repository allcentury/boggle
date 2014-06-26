require_relative 'lib/boggle'

board = %w[E E C A
           A L E P
           H N B O
           Q T T Y
           ]

puts Boggle.new(board).solve.results
