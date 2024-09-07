require_relative("Orbs")

class Board
  attr_accessor  :board,:score

  def initialize(fixed=false)
    @score=0
    row1=[]
    row2=[]
    row3=[]
    row4=[]
    row5=[]
    @board=[row1,row2,row3,row4,row5]

    if(fixed)
      @board[0][0]=Orbs.new("Puple")
      @board[1][0]=Orbs.new("Yellow")
      @board[2][0]=Orbs.new("Red")
      @board[3][0]=Orbs.new("Red")
      @board[4][0]=Orbs.new("Green")

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
      @board[1][3]=Orbs.new("Blue")
      @board[2][3]=Orbs.new("Blue")
      @board[3][3]=Orbs.new("Blue")
      @board[4][3]=Orbs.new("Red")

      @board[0][4]=Orbs.new("Green")
      @board[1][4]=Orbs.new("Purple")
      @board[2][4]=Orbs.new("Yellow")
      @board[3][4]=Orbs.new("Red")
      @board[4][4]=Orbs.new("Blue")

    self.initialRemoveMatchs()
      return
    end
    for row in @board
      row.push(Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new(),Orbs.new())
    end
    self.printBoard()
    self.initialRemoveMatchs()
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
    return



  end
  #helps the anyMatchOrReverse? mehtod at row level
  def anyMatchRowHelper(row)
    #match=[anyMatch?,row,column,howLong]
    match=[false]
    if([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
      match=[true,row,0,5,"row"]
      return match

    elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
      match=[true,row,0,4,"row"]
      return match

    elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
      match=[true,row,1,4,"row"]
      return match

    elsif([self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
      match=[true,row,2,3,"row"]
      return match

    elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
      match=[true,row,1,3,"row"]
      return match

    elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color].uniq.length==1)
      match=[true,row,0,3,"row"]
      return match
    end
    return match
  end
  #help the anyMatchOrReverse? method at column level
  def anyMatchColumnHelper(column)
    #match=[anyMatch?,row,column,howLong,columnOrRow]

    match=[false]
    if([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
      match=[true,0,column,5,"column"]
      return match
    end
    if([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
      match=[true,1,column,4,"column"]
      return match
    end
    if([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
      match=[true,0,column,4,"column"]
      return match
    end
    if([self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
      match=[true,2,column,3,"column"]
      return match
    end
    if([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
      match=[true,1,column,3,"column"]
      return match
    end
    if([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color].uniq.length==1)
      match=[true,0,column,3,"column"]
      return match
    end
    return match
  end
  #checks if there's a match in the baord and if not it will reverse the move
  def anyMatchOrReverse?(initial=false)
    row=0
    column=0
    while (row<=4)
      if([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,0,5,"row"],!initial)
        self.printBoard
        if(initial)
        @score+=5
        end
        return true

      elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
        removeOrbs([true,row,0,4,"row"],!initial)
        self.printBoard
        if(initial)
        @score+=4
       end
        return true

      elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,1,4,"row"],!initial)
        self.printBoard
        if(initial)
        @score+=4
        end
        return true

      elsif([self.board[row][2].color,self.board[row][3].color,self.board[row][4].color].uniq.length==1)
        removeOrbs([true,row,2,3,"row"],!initial)
        self.printBoard
        if(initial)
        @score+=3
       end
        return true

      elsif([self.board[row][1].color,self.board[row][2].color,self.board[row][3].color].uniq.length==1)
        removeOrbs([true,row,1,3,"row"],!initial)
        self.printBoard
       if(initial)
        @score+=3
       end
        return true

      elsif([self.board[row][0].color,self.board[row][1].color,self.board[row][2].color].uniq.length==1)
        removeOrbs([true,row,0,3,"row"],!initial)
        self.printBoard
       if(initial)
        @score+=3
       end
        return true
      end
      row+=1
    end
    while (column<=4)
      if([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,0,column,5,"column"],!initial)
        self.printBoard
        if(initial)
        @score+=5
        end
        return true

      elsif([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,1,column,4,"column"],!initial)
        self.printBoard
        if(initial)
        @score+=4
        end
        return true

      elsif([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
        removeOrbs([true,0,column,4,"column"],!initial)
        self.printBoard
        if(initial)
        @score+=4
        end
        return true

      elsif([self.board[2][column].color,self.board[3][column].color,self.board[4][column].color].uniq.length==1)
        removeOrbs([true,2,column,3,"column"],!initial)
        self.printBoard
        if(initial)
        @score+=3
        end
        return true

      elsif([self.board[1][column].color,self.board[2][column].color,self.board[3][column].color].uniq.length==1)
        removeOrbs([true,1,column,3,"column"],!initial)
        self.printBoard
        if(initial)
        @score+=3
        end
        return true

      elsif([self.board[0][column].color,self.board[1][column].color,self.board[2][column].color].uniq.length==1)
        removeOrbs([true,0,column,3,"column"],!initial)
        if(initial)
        @score+=3
        end
        return true
      end
      column+=1
    end
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
        # else
        #   self.board[row][column]=Orbs.new()
        #   self.board[row+1][column]=Orbs.new()
        #   self.board[row+2][column]=Orbs.new()
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
        #   else
        #     self.board[row][column]=Orbs.new()
        #     self.board[row+1][column]=Orbs.new()
        #     self.board[row+2][column]=Orbs.new()
        #     self.board[row+3][column]=Orbs.new()
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

    while(anyMatchOrReverse?(true))

    end

  end
end


board = Board.new(true)
board.printBoard()

print("Row index👉 ")
# row=gets().chomp!()
row=5
puts
print("Column index👉 ")
# column=gets().chomp!()
column=1
print("direction👉 ")
# direction=gets().chomp!()
direction="right"

board.generalMoveOrb(row.to_i,column.to_i,direction)
# streak=1
while(true)
  if( board.anyMatchOrReverse?())
    board.printBoard()
    next
  else
    break
  end
end
board.printBoard()
puts("you got #{board.score}")

