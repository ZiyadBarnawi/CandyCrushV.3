require_relative("Orbs")

class Board
  attr_accessor  :board

  def initialize
    row1=[]
    row2=[]
    row3=[]
    row4=[]
    row5=[]
    @board=[row1,row2,row3,row4,row5]


    for row in @board
      row.push(Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new())
    end
    
    
  end

  def [](index)
    return self.board[index]
  end

  def printBoard
    for row in self.board
      for orb in row
        print("#{orb}".rjust(8," "))
      end
      puts
    end
  end
  
  def moveOrbToDirection(row,column,direction)
    case direction
    when "right" 
      self.board[row][column],self.board[row][column+1]=self.board[row][column+1],self.board[row][column]
    when "left"
      self.board[row][column],self.board[row][column-1]=self.board[row][column-1],self.board[row][column]
    when "up"
      self.board[row][column],self.board[row-1][column]=self.board[row-1][column],self.board[row][column]
    when "down"
      self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
    else
      puts("that's not a valid option choose(right,left,up,down)")
      return

    end
  end
  def generalMoveOrb(row,column,direction)
    row-=1
    column-=1

    if(column==4&& direction=="right"|| column==0&& direction=="left"||row==0&&direction=="up"|| row==4&&direction=="down")
      puts("You can't make move orbs outside of the board")
      return
    end

    moveOrbToDirection(row,column,direction);
    return

    

  end
  def anyMatchRowHelper(row)
      match=[false]
      if([self.board[row][0],self.board[row][1],self.board[row][2]].uniq.length==1)
        match=[true,row,0]
      end
      if([self.board[row][1],self.board[row][2],self.board[row][3]].uniq.length==1)
        match=[true,row,1]
      end
      if([self.board[row][2],self.board[row][3],self.board[row][4]].uniq.length==1)
        match=[true,row,2]
      end
    return match
  end
  def anyMatchColumnHelper(column)
    match=[false]
      if([self.board[0][column],self.board[1][column],self.board[2][column]].uniq.length==1)
        
        match=[true,0,column]
      end
      if([self.board[1][column],self.board[2][column],self.board[3][column]].uniq.length==1)
        match=[true,1,column]

      end
      if([self.board[2][column],self.board[3][column],self.board[4][column]].uniq.length==1)
        match=[true,2,column]

      end
    return match
  end
  def anyMatch?
    
    puts("#{anyMatchRowHelper(0)} in the anyMatchRowHelepr")
    puts("#{anyMatchColumnHelper(2)} in the anyMatchColumnHelepr")
      
    puts("Match!")
    
  end

end


board=Board.new()
# board.printBoard()
# puts
# puts
# board.generalMoveOrb(1,1,"down")
# board.printBoard
puts(
  board[0][2]="Blue",
  board[1][2]="Blue",
  board[2][2]="Blue"
  )
  board.printBoard()
  board.anyMatch?
