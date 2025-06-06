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
      if(board[row][column] != 0){
        sumOfBlocks++;
      }
    }
    
    return sumOfBlocks;
  }
  
  public double clearRows(){
    int rowsCleared = 0;
    
    for (int row = 0; row < 24; row++){
      if (rowSum(row)==15){
        rowsCleared ++;
        pushDown(row);
      }
    }
    return Math.pow((double)rowsCleared,2.0)*1000;
  }
  public void setEqualTo(int[] row1, int[] row2){
    for (int i = 0; i<row1.length; i++){
      row2[i] = row1[i];
    }
  }
  public void pushDown(int row){
    for(int i = row; i>0; i--){
      board[i] = board[i-1];
    }
    board[0] = new int[15];
  }
  void display(){
    
    for (int i = 0; i < 24; i++){
      for (int j = 0; j < 15; j++){
        float[] colarr = colors.get(colorRef.get(board[i][j]));
        displayMino(j,i,colarr,SQUARE_SIZE,false);
      }
    }
  }
  
  public int getmino(int[] coord){
    return board[coord[0]][coord[1]];
  }
  public void setmino(int[] coord, int val){
    board[coord[0]][coord[1]] = val;
  }
  public boolean emptyIndex(int row, int col){
    return (!(row >= 24 || col >=15 || col<0))&&(board[row][col]==0);
  }
}
