/*
add the following to the board class
  board(duh)
  checkRow()
  clearRow()
  
additional features we forgot
  hold block
*/

class Board{
  int[][] board;
  
  public Board(){
    this.board = new int[40][12];
  }
  
  public boolean checkRow(int row){
    int sumOfBlocks = 0;
    for (int column = 0; column < 21; column++){
      sumOfBlocks += board[row][column];
    }
    
    return sumOfBlocks == 12;
  }
  
  public int clearRows(){
    int addToScore = 0;
    
    for (int row = 0; row < 40; row++){
      if (checkRow(row)){
        board[row] = new int[12];
        addToScore += 12;
      }
    }
    
    return addToScore;
  }
  
  void display(){
    
  }
  
  public int getmino(int[] coord){
    return board[40-coord[1]-1][coord[0]];
  }
  public void setmino(int[] coord, int val){
    board[40-coord[1]-1][coord[0]] = val;
  }
}
