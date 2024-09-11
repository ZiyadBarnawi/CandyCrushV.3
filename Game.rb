require_relative 'Board'


board = Board.new()
for i in 1..5

  print("Row index👉 ")
  row=gets().chomp!()
  # row=2
  puts
  print("Column index👉 ")
  column=gets().chomp!()
  # column=2
  puts
  print("direction👉 ")
  direction=gets().chomp!()
  # direction="left"

  board.generalMoveOrb(row.strip().to_i(),column.strip().to_i,direction.strip())

  while(true)
    if( board.anyMatch?())
      board.printBoard()
      board.potentialMatchOrRefresh?()
      next
    else
      board.potentialMatchOrRefresh?()
      break
    end
  end
  until(board.potentialMatchOrRefresh?())
    next
  end
  # board.printBoard()
end
puts("you got #{board.score}")
