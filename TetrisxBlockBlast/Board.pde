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
  
  public boolean checkRow(){
    
  }
  
  public void clearRow(int row){
    
  }
  
  public int getmino(int[] coord){
    return board[40-coord[1]-1][coord[0]];
  }
  public void setmino(int[] coord, int val){
    board[40-coord[1]-1][coord[0]] = val;
  }
}
