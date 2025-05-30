/*
add the following to the board class
  board(duh)
  checkRow()
  clearRow()
  
additional features we forgot
  hold block
*/

static final int SQUARE_SIZE = 30;

class Board{
  int[][] board;
  
  public Board(){
    this.board = new int[24][15];
  }
  
  public int rowSum(int row){
    int sumOfBlocks = 0;
    for (int column = 0; column < 15; column++){
      sumOfBlocks += board[row][column];
    }
    
    return sumOfBlocks;
  }
  
  public int clearRows(){
    int addToScore = 0;
    
    for (int row = 0; row < 24; row++){
      if (rowSum(row)==15){
        addToScore += 15;
        board[row] = new int[15];
      }
      pushDown();
    }
    return addToScore;
  }
  
  public void pushDown(){
    for(int row = 23; row >= 0; row--){
      if(rowSum(row) == 0){
        for(int i = row; i>0; i--){
          board[row]=board[row-1];
        }
      }
    }
  }
  
  void display(){
    stroke(50);
    for (int i = 0; i < 15; i++){
      for (int j = 0; j < 24; j++){
        if (board[j][i] == 0){
          fill(10);
        }
        else{
          fill(255);
        }
        
        square(i * SQUARE_SIZE, j * SQUARE_SIZE, SQUARE_SIZE);
      }
    }
  }
  
  public int getmino(int[] coord){
    return board[24-coord[1]-1][coord[0]];
  }
  public void setmino(int[] coord, int val){
    board[24-coord[1]-1][coord[0]] = val;
  }
}
