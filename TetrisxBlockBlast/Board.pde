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
    this.board = new int[40][15];
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
    
    for (int row = 16; row < 40; row++){
      if (rowSum(row)==15){
        addToScore += 15;
        board[row] = new int[15];
      }
      pushDown();
    }
    return addToScore;
  }
  
  public void pushDown(){
    for(int row = 40; row >= 16; row--){
      if(rowSum(row) == 0){
        for(int i = row; i>0; i--){
          board[row]=board[row-1];
        }
      }
    }
  }
  
  void display(){
    stroke(50);
    for (int i = 0; i < 24; i++){
      for (int j = 0; j < 15; j++){
        if (board[i+16][j] == 0){
          fill(10);
        }
        else{
          fill(255);
        }
        
        square(j * (SQUARE_SIZE), i * (SQUARE_SIZE), SQUARE_SIZE);
      }
    }
  }
  
  public int getmino(int[] coord){
    return board[16+coord[1]][coord[0]];
  }
  public void setmino(int[] coord, int val){
    board[16+coord[1]][coord[0]] = val;
  }
  public boolean emptyIndex(int row, int col){
    boolean valid = !(row >= 40 || col >=15 || col<0);
    boolean empty = (valid && board[row+16][col]==0);
    return valid && empty;
  }
}
