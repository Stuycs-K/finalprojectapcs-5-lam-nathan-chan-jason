/*
add the following to the board class
  board(duh)
  checkRow()
  clearRow()
  
additional features we forgot
  hold block
*/

static final int SQUARE_SIZE = 20;

class Board{
  int[][] board;
  
  public Board(){
    this.board = new int[40][12];
  }
  
  public int rowSum(int row){
    int sumOfBlocks = 0;
    for (int column = 0; column < 12; column++){
      sumOfBlocks += board[row][column];
    }
    
    return sumOfBlocks;
  }
  
  public int clearRows(){
    int addToScore = 0;
    
    for (int row = 0; row < 40; row++){
      if (rowSum(row)==12){
        addToScore += 12;
      }
      pushDown();
    }
    return addToScore;
  }
  
  public void pushDown(){
    for(int row = 39; row >= 0; row--){
      if(rowSum(row) == 0){
        for(int i = row; i>0; i--){
          board[row]=board[row-1];
        }
      }
    }
  }
  
  void display(){
    int row = height % SQUARE_SIZE, column = width % SQUARE_SIZE;
    stroke(255);
    for (int i = 1; i <= 12; i++){
      for (int j = 0; j < 40; j++){
        if (board[j][i - 1] == 0){
          fill(0);
        }
        else{
          fill(255);
        }
        
        square(i * SQUARE_SIZE + 250, j * SQUARE_SIZE + 2, SQUARE_SIZE);
      }
    }
  }
  
  public int getmino(int[] coord){
    return board[40-coord[1]-1][coord[0]];
  }
  public void setmino(int[] coord, int val){
    board[40-coord[1]-1][coord[0]] = val;
  }
}
