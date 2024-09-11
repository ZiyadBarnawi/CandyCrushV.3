require_relative("Orbs")

class Board
  attr_accessor  :board,:score

  def initialize(fixed=false)
    @score=0
    @board=[]
    self.refresh()

    if(fixed)
      self.fixed()
    end
    self.printBoard()
    self.initialRemoveMatchs()
  end
  def fixed()

      @board[0][0]=Orbs.new("Purple")
      @board[1][0]=Orbs.new("Yellow")
      @board[2][0]=Orbs.new("Red")
      @board[3][0]=Orbs.new("Red")
      @board[4][0]=Orbs.new("Purple")

      @board[0][1]=Orbs.new("Green")
      @board[1][1]=Orbs.new("Red")
      @board[2][1]=Orbs.new("Puple")
      @board[3][1]=Orbs.new("Green")
      @board[4][1]=Orbs.new("Green")

      @board[0][2]=Orbs.new("Red")
      @board[1][2]=Orbs.new("Purple")
      @board[2][2]=Orbs.new("Red")
      @board[3][2]=Orbs.new("Yellow")
      @board[4][2]=Orbs.new("Green")

      @board[0][3]=Orbs.new("Blue")
      @board[1][3]=Orbs.new("Yellow")
      @board[2][3]=Orbs.new("Blue")
      @board[3][3]=Orbs.new("Yellow")
      @board[4][3]=Orbs.new("Red")

      @board[0][4]=Orbs.new("Green")
      @board[1][4]=Orbs.new("Purple")
      @board[2][4]=Orbs.new("Yellow")
      @board[3][4]=Orbs.new("Red")
      @board[4][4]=Orbs.new("Blue")



  end
  def refresh()
    while(!self.board.empty?)
      self.board.pop()
    end
    row1=[]
    row2=[]
    row3=[]
    row4=[]
    row5=[]
    self.board=[row1,row2,row3,row4,row5]
    for row in @board
      row.push(Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new())
    end

  end
  def [](index)
    return self.board[index]
  end
  #Prints the board
  def printBoard
    puts
    puts
    for row in self.board
      for orb in row
        print("#{orb}".rjust(8," "))
      end
      puts
    end
    puts
    puts
  end
  #makes the actual move
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

  #a general method for moving an orb that checks if the move is allowed
  def generalMoveOrb(row,column,direction)

    row-=1
    column-=1

    if(column==4&& direction=="right"|| column==0&& direction=="left"||row==0&&direction=="up"|| row==4&&direction=="down")
      puts("You can't make move orbs outside of the board")
      return
    end
    moveOrbToDirection(row,column,direction);
    if(!anyMatch?)
      moveOrbToDirection(row,column,direction)
      puts("You can't make this move")
    end
    return
  end
  #like the general move function but this one doesn't affect the real board
  def fakeGeneralMoveOrb(row,column,direction,boardCopy)
    if(column==4&& direction=="right"|| column==0&& direction=="left"||row==0&&direction=="up"|| row==4&&direction=="down")
      return
    end
    fakeMoveOrbToDirection(row,column,direction,boardCopy)
    if(!self.fakeAnyMatch?(boardCopy))
      fakeMoveOrbToDirection(row,column,direction,boardCopy)
      return false

    end
    return true
  end
  def fakeMoveOrbToDirection(row,column,direction,boardCopy)
    case direction
    when "right"
      boardCopy.board[row][column],boardCopy.board[row][column+1]=boardCopy.board[row][column+1],boardCopy.board[row][column]
    when "left"
      boardCopy.board[row][column],boardCopy.board[row][column-1]=boardCopy.board[row][column-1],boardCopy.board[row][column]
    when "up"
      boardCopy.board[row][column],boardCopy.board[row-1][column]=boardCopy.board[row-1][column],boardCopy.board[row][column]
    when "down"
      boardCopy.board[row][column],boardCopy.board[row+1][column]=boardCopy.board[row+1][column],boardCopy.board[row][column]
    else
      return

    end
  end
  def anyMatch?(initial=false)
    row=0
    column=0
    while (row<=4)
      if([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,0,5,"row"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=5
        return true

      elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
        removeOrbs([true,row,0,4,"row"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=4
        return true

      elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,1,4,"row"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=4
        return true

      elsif([self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,2,3,"row"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=3
        return true

      elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
        removeOrbs([true,row,1,3,"row"],!initial)
        self.printBoard
       if(initial)
         return true
       end
        @score+=3
        return true

      elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color].uniq.length==1)
        removeOrbs([true,row,0,3,"row"],!initial)
        self.printBoard
       if(initial)
         return true
       end
        @score+=3
        return true
      end
      row+=1
    end
    while (column<=4)
      if([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,0,column,5,"column"],!initial)
        self.printBoard
        if(initial)
        return true
        end
        @score+=5
        return true

      elsif([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
        removeOrbs([true,0,column,4,"column"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=4
        return true

      elsif([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,1,column,4,"column"],!initial)
        self.printBoard
        if(initial)
        return true
        end
        @score+=4
        return true

      elsif([self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,2,column,3,"column"],!initial)
        self.printBoard
        if(initial)
        return true
        end
        @score+=3
        return true

      elsif([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
        removeOrbs([true,1,column,3,"column"],!initial)
        self.printBoard
        if(initial)
          return true
        end
        @score+=3
        return true

      elsif([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color].uniq.length==1)
        removeOrbs([true,0,column,3,"column"],!initial)
        if(initial)
          return true
        end
        @score+=3
        return true
      end
      column+=1
    end
    return false
  end
  def fakeAnyMatch?(boardCopy)
    row=0
    column=0
    while (row<=4)
      if([boardCopy.board[row][0].color,boardCopy.board[row][1].color,boardCopy.board[row][2].color,boardCopy.board[row][3].color,boardCopy.board[row][4].color].uniq.length==1)

        return true

      elsif([boardCopy.board[row][0].color,boardCopy.board[row][1].color,boardCopy.board[row][2].color,boardCopy.board[row][3].color].uniq.length==1)

        return true

      elsif([boardCopy.board[row][1].color,boardCopy.board[row][2].color,boardCopy.board[row][3].color,boardCopy.board[row][4].color].uniq.length==1)

        return true

      elsif([boardCopy.board[row][2].color,boardCopy.board[row][3].color,boardCopy.board[row][4].color].uniq.length==1)

        return true

      elsif([boardCopy.board[row][1].color,boardCopy.board[row][2].color,boardCopy.board[row][3].color].uniq.length==1)

        return true

      elsif([boardCopy.board[row][0].color,boardCopy.board[row][1].color,boardCopy.board[row][2].color].uniq.length==1)

        return true
      end
      row+=1
    end
    while (column<=4)
      if([boardCopy.board[0][column].color,boardCopy.board[1][column].color,boardCopy.board[2][column].color,boardCopy.board[3][column].color,boardCopy.board[4][column].color].uniq.length==1)

        return true

      elsif([boardCopy.board[0][column].color,boardCopy.board[1][column].color,boardCopy.board[2][column].color,boardCopy.board[3][column].color].uniq.length==1)

        return true

      elsif([boardCopy.board[1][column].color,boardCopy.board[2][column].color,boardCopy.board[3][column].color,boardCopy.board[4][column].color].uniq.length==1)

        return true

      elsif([boardCopy.board[2][column].color,boardCopy.board[3][column].color,boardCopy.board[4][column].color].uniq.length==1)

        return true

      elsif([boardCopy.board[1][column].color,boardCopy.board[2][column].color,boardCopy.board[3][column].color].uniq.length==1)

        return true

      elsif([boardCopy.board[0][column].color,boardCopy.board[1][column].color,boardCopy.board[2][column].color].uniq.length==1)

        return true
      end
      column+=1
    end
    return false
    end
    #Checks if there's a potional match in thr board. else, it'll refresh the board
  def potentialMatchOrRefresh?()
    if(potentialMatchHelper())
      return true
    end
    puts("There are no potional matches. so, we'll refresh the board")
    self.refresh()
    self.initialRemoveMatchs()
    self.printBoard()
    return false
  end

  def potentialMatchHelper()
    boardCopy=Marshal.load( Marshal.dump(self))
    boardCopy.board.each_with_index() do|row, i|
      row.each_with_index() do|orb,j|

        fakeGeneralMoveOrb(i,j,"right",boardCopy)
        if(fakeAnyMatch?(boardCopy))
          return true

        end
        fakeGeneralMoveOrb(i,j,"left",boardCopy)
        if(fakeAnyMatch?(boardCopy))
          return true

        end
        fakeGeneralMoveOrb(i,j,"up",boardCopy)
        if(fakeAnyMatch?(boardCopy))
          return true

        end
        fakeGeneralMoveOrb(i,j,"down",boardCopy)
        if(fakeAnyMatch?(boardCopy))
          return true

        end

      end

    end
    puts("no potional matches.")
    return false


  end

  #remove the orbs that are matching
  def removeOrbs(matchInfo=[],message=true)
    #
    #matchInfo=[state,row,column,length,"rowOrColumn"]
    row=matchInfo[1]
    column=matchInfo[2]
    oldColumn=column

    if(matchInfo[4]=="row")

      if(matchInfo[3]==3)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        while(self.board[row+1]!=nil)
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]



          row+=1
          column=oldColumn

        end
        self.board[row][column]=Orbs.new()
        self.board[row][column+1]=Orbs.new()
        self.board[row][column+2]=Orbs.new()
        return
      end
      if(matchInfo[3]==4)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        while(self.board[row+1]!=nil)
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          row+=1
          column=oldColumn

        end
        self.board[row][column]=Orbs.new()
        self.board[row][column+1]=Orbs.new()
        self.board[row][column+2]=Orbs.new()
        self.board[row][column+3]=Orbs.new()
        return
      end

      if(matchInfo[3]==5)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        while(self.board[row+1]!=nil)
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]
          column+=1
          self.board[row][column],self.board[row+1][column]=self.board[row+1][column],self.board[row][column]

          row+=1
          column=oldColumn

        end
        self.board[row][column]=Orbs.new()
        self.board[row][column+1]=Orbs.new()
        self.board[row][column+2]=Orbs.new()
        self.board[row][column+3]=Orbs.new()
        self.board[row][column+4]=Orbs.new()
        return
      end
      #######################################################################################
      #matchInfo=[state,row,column,length,"rowOrColumn"]

    elsif(matchInfo[4]=="column")

      if(matchInfo[3]==3)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        if(self.board[row+3]!=nil)
          self.board[row][column]=self.board[row+3][column]
          if(self.board[row+4]!=nil)
            self.board[row+1][column]=self.board[row+4][column]
          end
          else
          while(self.board[row+2]!=nil)
            self.board[row+2][column]=Orbs.new()
            row+=1
          end

        end


        # return
      end

      if(matchInfo[3]==4)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        if(self.board[row+4]!=nil)
          self.board[row][column]=self.board[row+4][column]
        else
          while(self.board[row+1]!=nil)
            self.board[row+1][column]=Orbs.new()
            row+=1

          end

        end
        # return
      end
      if(matchInfo[3]==5)
        if(message)
        puts("#{matchInfo[3]} orbs matched at row #{matchInfo[1]+1} and column #{matchInfo[2]+1}")
        end
        while(self.board[row]!=nil)
          self.board[row][column]=Orbs.new()
          row+=1
        end

      end

    end
    return true
  end
  #remove inital matches in the board aapon creation
  def initialRemoveMatchs

    while(anyMatch?(true))

    end

  end
  #Helps the potintialMatch? method by checking if there a a match. the code is similar to the anyMatch? but in the same time differant to be it's own function
  end
board = Board.new(true)
board.printBoard()
for i in 1..5

print("Row index👉 ")
row=gets().chomp!()
# row=2
puts
print("Column index👉 ")
column=gets().chomp!()
# column=2
print("direction👉 ")
direction=gets().chomp!()
# direction="left"

board.generalMoveOrb(row.strip().to_i(),column.strip().to_i,direction.strip())

while(true)
  if( board.anyMatch?())
    board.printBoard()
    board.potintialMatch?()
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

