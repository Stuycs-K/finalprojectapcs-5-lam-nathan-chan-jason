import java.util.*;
//when doing rotations, use a 3d array that stores all of the possible rotations so that you can simply call it when rotating a piece

class Tetromino{

  private int[][] i = new int[][] {new int[5], new int[5], {0,1,1,1,1}, new int[5], new int[5]};
  private int[][] l = new int[][] {{0,0,1},{1,1,1},{0,0,0}};
  private int[][] j = new int[][] {{1,0,0},{1,1,1},{0,0,0}};
  private int[][] o = new int[][] {{0,1,1},{0,1,1},{0,0,0}};
  private int[][] s = new int[][] {{0,1,1},{1,1,0},{0,0,0}};
  private int[][] z = new int[][] {{1,1,0},{0,1,1},{0,0,0}};
  private int[][] t = new int[][] {{0,1,0},{1,1,1},{0,0,0}};

  private Hashtable<String, int[][]> initshape = new Hashtable<String, int[][]>();

  initshape.put("i", i);
  initshape.put("l",l);

  private int[][] shape;
  private String shapeident;
  private int ccol, crow;
  public Tetromino(String shapeident, int[] startingpos){
    this.shape = shape;
    ccol = startingpos[0];
    crow = startingpos[1];

  }
  public void move(int deltax, int deltay){
    ccol += deltax;
    crow += deltay;
  }

  public void rotate(){
  }
}
