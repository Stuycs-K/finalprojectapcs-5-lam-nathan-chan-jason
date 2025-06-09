import java.util.*;
//when doing rotations, use a 3d array that stores all of the possible rotations so that you can simply call it when rotating a piece

class Tetromino{
 //all of the base shapes in their respective 3D arrays
  private final int[][][] i = new int[][][] {
{new int[5], new int[5], {0,1,1,1,1}, new int[5], new int[5]},
{new int[5],{0,0,1,0,0},{0,0,1,0,0},{0,0,1,0,0},{0,0,1,0,0}},
{new int[5],new int[5],{1,1,1,1,0},new int[5],new int[5]},
{{0,0,1,0,0},{0,0,1,0,0},{0,0,1,0,0},{0,0,1,0,0},new int[5]}
};
  private final int[][][] l = new int[][][] {
{{0,0,2},{2,2,2},new int[3]},
{{0,2,0},{0,2,0},{0,2,2}},
{new int[3],{2,2,2},{2,0,0}},
{{2,2,0},{0,2,0},{0,2,0}}
};
  private final int[][][] j = new int[][][] {
  {{3,0,0},{3,3,3},{0,0,0}},
{{0,3,3},{0,3,0},{0,3,0}},
{new int[3],{3,3,3},{0,0,3}},
{{0,3,0},{0,3,0},{3,3,0}}};
  private final int[][][] o = new int[][][] {
  {{0,4,4},{0,4,4},new int[3]},
{new int[3],{0,4,4},{0,4,4}},
{new int[3],{4,4,0},{4,4,0}},
{{4,4,0},{4,4,0},new int[3]}};
  private final int[][][] s = new int[][][] {
  {{0,5,5},{5,5,0},new int[3]},
{{0,5,0},{0,5,5},{0,0,5}},
{new int[3],{0,5,5},{5,5,0}},
{{5,0,0},{5,5,0},{0,5,0}}};
  private final int[][][] z = new int[][][] {
  {{6,6,0},{0,6,6},{0,0,0}},
{{0,0,6},{0,6,6},{0,6,0}},
{{0,0,0},{6,6,0},{0,6,6}},
{{0,6,0},{6,6,0},{6,0,0}}};
  private final int[][][] t = new int[][][] {
  {{0,7,0},{7,7,7},new int[3]},
{{0,7,0},{0,7,7},{0,7,0}},
{new int[3],{7,7,7},{0,7,0}},
{{0,7,0},{7,7,0},{0,7,0}}};
private final int[][] Ocomp = new int[][]
  {{8,8,8},{8,0,8},{8,8,8}};

private final int[][][] O = new int[][][] {Ocomp,Ocomp,Ocomp,Ocomp};
private final int[][][] L = new int[][][]{
  {{9,0,0},{9,0,0},{9,9,9}},
  {{9,9,9},{9,0,0},{9,0,0}},
  {{9,9,9},{0,0,9},{0,0,9}},
  {{0,0,9},{0,0,9},{9,9,9}}
};
private final int[][][] Di2 = new int[][][]{
  {{0,0,10},{0,10,0},{0,0,0}},
  {{0,0,0},{0,10,0},{0,0,10}},
  {{0,0,0},{0,10,0},{10,0,0}},
  {{10,0,0},{0,10,0},{0,0,0}},
};
private final int[][][] Di3 = new int[][][]{
  {{11,0,0},{0,11,0},{0,0,11}},
  {{0,0,11},{0,11,0},{11,0,0}},
  {{11,0,0},{0,11,0},{0,0,11}},
  {{0,0,11},{0,11,0},{11,0,0}},
};
private final int[][][] Z = new int[][][]{
  {{12,12,0},{0,12,0},{0,12,12}},
  {{0,0,12},{12,12,12},{12,0,0}},
  {{12,12,0},{0,12,0},{0,12,12}},
  {{0,0,12},{12,12,12},{12,0,0}}
};
private final int[][][] S = new int[][][]{
  {{0,13,13},{0,13,0},{13,13,0}},
  {{13,0,0},{13,13,13},{0,0,13}},
  {{0,13,13},{0,13,0},{13,13,0}},
  {{13,0,0},{13,13,13},{0,0,13}}
};

//tetris's actual rotation system uses offset values to do wallkicks. this is it here.
//O is the initial rotation state, R and L are after one right and left rotation (CW and CCW) respectively, and F is a full 180° rotation.

private Hashtable<String, int[][][]> offsets = new Hashtable<String, int[][][]>();

//3x3 tiles
  private int[][][] triple = new int[][][]{
    new int[5][2],
    {new int[2],{1,0},{1,-1},{0,2},{1,2}},
    new int[5][2],
    {new int[2],{-1,0},{-1,-1},{0,2},{-1,2}} 
  };
  
//specific O tile  
  private final int[][][] square = new int[][][] {{{0,0},{0,-1},{-1,-1},{-1,0}}};
 
//5x5 tiles
  private int[][][] penta = new int[][][] {
    {{0,0},{-1,0},{2,0},{-1,0},{2,0}},
    {{-1,0},{0,0},{0,0},{0,1},{0,-2}},
    {{-1,1},{1,1},{-2,1},{1,0},{-2,0}},
    {{0,1},{0,1},{0,1},{0,-1},{0,2}}
  };
  
//colors

  
  private String shapeIdent;
  private Board board;
  private Hashtable<String, int[][][]> initshape = new Hashtable<String, int[][][]>();
  private int[][][] shape;
  public int col, row;
  private int current = 0;
  public Tetromino(String shapeident, int[] startingpos, Board board){
    row = startingpos[0];
    col = startingpos[1];
    this.board = board;
    
    this.shapeIdent = shapeident;
    
    
    //simplifying selection of shape
    initshape.put("i",i);
    initshape.put("l",l);
    initshape.put("j",j);
    initshape.put("o",o);
    initshape.put("s",s);
    initshape.put("z",z);
    initshape.put("t",t);
    initshape.put("L",L);
    initshape.put("O",O);
    initshape.put("Di2",Di2);
    initshape.put("Di3",Di3);
    initshape.put("Z",Z);
    initshape.put("S",S);
    this.shape = initshape.get(shapeident);
    
    offsets.put("3x3",triple);
    offsets.put("o",square);
    offsets.put("5x5",penta);
    
  }
  //moves..
  public void move(int deltax, int deltay){
    col += deltax;
    row += deltay;
  }
  //instantly moves tetromino to the bottom, where the ghost is
  public void harddrop(){
    while(onBoard(row+1, col)){
      row++;
    }
    transfer();
  }
  //transfers a tetromino from a object to just data on the board array.
   public void transfer(){
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0; j<shape[current].length;j++){
        if (this.shape[current][i][j] != 0){
          this.board.setmino(new int[]{row+i,col+j},this.shape[current][i][j]);
        }
      }
    }
  }
//rotates a tetromino by switching the index of the 3D array, and applies wallkick translations ripped directly from the original game.  if not possible, doesnt rotate.
  public void rotate(boolean CW){    
    boolean canrotate = true;
    if(CW){
      current ++;
    }else{
      current --; 
    }
    current = (current+4)%4;
    int[] testoff = new int[2];
    for(int i = 0; i<5; i++){
      testoff = calcOffset(CW, i);
      if (onBoard(row-testoff[1],col+testoff[0])){
        break;
      }
      canrotate = false;
    }
    if(canrotate){
      row -= testoff[1];
      col += testoff[0];
    }else{
      if(CW)current --;
      else current ++;
      current = (current +4)%4;
    }
  }  
  //no-arg display
  public void display(){
    display(this.row, this.col, false);
  }
  //displays at a specific location, specifically used in the ghost
  public void display(int drow, int dcol, boolean fade){
    int SQUARE_SIZE = 30;
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0;j<shape[current].length; j++){
        int select = shape[current][i][j];
        if(select != 0){
          float[] co = colors.get(colorRef.get(select));
          displayMino(dcol+j, drow+i, co,SQUARE_SIZE, fade);
        }
      }
    }
  }
  //displays the ghost in a little outline fashion
  public void displayGhost(){
    int grow = row, gcol = col;
    while(onBoard(grow+1, gcol)){
      grow++;
    }
    display(grow, gcol, true);
  }
  //used for displaying the next and stored tetrominos
  public void displayInUI(String where){
    int SQUARE_SIZE = 20;
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0;j<shape[current].length; j++){
        int select = shape[current][i][j];
        if(select != 0){
          float[] co = colors.get(colorRef.get(select));
          if (where == "next"){
            if (this.shapeIdent == "i"){
              displayMino(23 + j, 8 + i, co,SQUARE_SIZE,false);
            }
            else{
              displayMino(24 + j, 9 + i, co,SQUARE_SIZE,false);
            }
          }else if (where == "hold"){
            if (this.shapeIdent == "i"){
              displayMino(23 + j, 15 + i, co,SQUARE_SIZE,false);
            }
            else{
              displayMino(24 + j, 16 + i, co,SQUARE_SIZE,false);
            }
          }
        }
      }
    }
  }
  //checks if the tetromino is overlapping anything or is off the board
  public boolean onBoard(int crow,int ccol){
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0; j<shape[current][i].length; j++){
        if(this.shape[current][i][j] != 0 && !board.emptyIndex(crow+i,ccol+j)){
          return false;
        }
      }
    }
    return true;
  }
  //calculates the translation offsets from intarrays ripped from tetris
  public int[] calcOffset(boolean CW, int testNo){
    int[][][] subOffset;
    if(this.shape[current].length == 3){
      if(shapeIdent == "o"||shapeIdent == "Di2"){
        subOffset = offsets.get("o");
        int[] testoff;
        if(CW){
          testoff = subOffset[0][(current+3)%4];}
        else{
          testoff = subOffset[0][(current+1)%4];}
        int[] diffoff = subOffset[0][current];
        int[] finaloff = {testoff[0]-diffoff[0], testoff[1]-diffoff[1]};
        return finaloff;
      }else{
        subOffset = offsets.get("3x3");
      }
    }else{
      subOffset = offsets.get("5x5");
    }
    
    int[][] initvals;
    int[][] changevals = subOffset[current];
    if (CW){
      initvals = subOffset[(current+3)%4];
    }else{
      initvals = subOffset[(current + 1)%4];
    }
    
    int[] testoff = new int[] {initvals[testNo][0],initvals[testNo][1]};

    int[] diffoff = new int[] {changevals[testNo][0],changevals[testNo][1]};
    testoff[0] -= diffoff[0];
    testoff[1] -= diffoff[1];
    return testoff;
    
  }
 
  public String getShapeIdent(){
    return shapeIdent;
  }
}
