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
{{0,0,1},{1,1,1},new int[3]},
{{0,1,0},{0,1,0},{0,1,1}},
{new int[3],{1,1,1},{1,0,0}},
{{1,1,0},{0,1,0},{0,1,0}}
};
  private final int[][][] j = new int[][][] {
  {{1,0,0},{1,1,1},{0,0,0}},
{{0,1,1},{0,1,0},{0,1,0}},
{new int[3],{1,1,1},{0,0,1}},
{{0,1,0},{0,1,0},{1,1,0}}};
  private final int[][][] o = new int[][][] {
  {{0,1,1},{0,1,1},new int[3]},
{new int[3],{0,1,1},{0,1,1}},
{new int[3],{1,1,0},{1,1,0}},
{{1,1,0},{1,1,0},new int[3]}};
  private final int[][][] s = new int[][][] {
  {{0,1,1},{1,1,0},new int[3]},
{{0,1,0},{0,1,1},{0,0,1}},
{new int[3],{0,1,1},{1,1,0}},
{{1,0,0},{1,1,0},{0,1,0}}};
  private final int[][][] z = new int[][][] {
  {{1,1,0},{0,1,1},{0,0,0}},
{{0,0,1},{0,1,1},{0,1,0}},
{{0,0,0},{1,1,0},{0,1,1}},
{{0,1,0},{1,1,0},{1,0,0}}};
  private final int[][][] t = new int[][][] {
  {{0,1,0},{1,1,1},new int[3]},
{{0,1,0},{0,1,1},{0,1,0}},
{new int[3],{1,1,1},{0,1,0}},
{{0,1,0},{1,1,0},{0,1,0}}};

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
    this.shape = initshape.get(shapeident);
    
    offsets.put("3x3",triple);
    offsets.put("o",square);
    offsets.put("5x5",penta);
    
  }
  public void move(int deltax, int deltay){
    col += deltax;
    row += deltay;
  }
  public void fastFall(){
    while(onBoard(row+1, col)){
      row++;
    }
    transfer();
  }
  public void transfer(){
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0; j<shape[current].length;j++){
        if (this.shape[current][i][j] != 0){
          this.board.setmino(new int[]{row+i,col+j},1);
        }
      }
    }
  }

  public void rotate(boolean CW){    
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
    }
    row -= testoff[1];
    col += testoff[0];
    
  }  
  public void display(){
 
    int SQUARE_SIZE = 30;
    stroke(150);
    strokeWeight(5);
    fill(255);
    for(int i = 0; i<shape[current].length; i++){
      for(int j = 0;j<shape[current].length; j++){
        if(shape[current][i][j] == 1){
          square((SQUARE_SIZE)*(col+j), (SQUARE_SIZE)*(row+i), SQUARE_SIZE);
        }
      }
    }
  }
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
  public int[] calcOffset(boolean CW, int testNo){
    int[][][] subOffset;
    if(this.shape[current].length == 3){
      if(shapeIdent == "o"){
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
}
