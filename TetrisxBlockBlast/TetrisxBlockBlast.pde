private Tetromino activemino, heldmino, nextmino;
private Board board;
private int frame = 0, speed = 35, score = 0;
private boolean alreadyClickedHeld, winning;

public Hashtable<String, float[]> colors = new Hashtable<String, float[]>();
  final float[] empt = {0,0,20};
  final float[] ci = new float[]{180,100,100};
  final float[] co = new float[]{50,100,100};
  final float[] cl = new float[]{39,100,100};
  final float[] cj = new float[]{240,100,100};
  final float[] cs = new float[]{120,100,100};
  final float[] cz = new float[]{0,100,100};
  final float[] ct = new float[]{277,87,100};

public Hashtable<Integer,String> colorRef = new Hashtable<Integer,String>();

void setup(){
  colorMode(HSB,360,100,100);
  colorRef.put(0,"empty");
  colorRef.put(1,"i");
  colorRef.put(2,"l");
  colorRef.put(3,"j");
  colorRef.put(4,"o");
  colorRef.put(5,"s");
  colorRef.put(6,"z");
  colorRef.put(7,"t");

  colors.put("empty",empt);
  colors.put("i",ci);
  colors.put("o",co);
  colors.put("l",cl);
  colors.put("j",cj);
  colors.put("s",cs);
  colors.put("z",cz);
  colors.put("t",ct);

  background(210);
  size(600, 720);
  fill(0);
  textSize(48);
  text("Score", 469, 40);
  text("Next", 469, 150);
  text("Hold", 469, 300);

  board = new Board();
  activemino = newMino();
  nextmino = newMino();
  heldmino = null;
  alreadyClickedHeld = false;
  winning = true;
}

void draw(){
  background(210);
  text("Score", 469, 40);
  text("Next", 469, 150);
  text("Hold", 469, 300);
  board.display();
  activemino.display();
  nextmino.displayInUI("next");
  if (heldmino != null){
    heldmino.displayInUI("hold");
  }
  fill(0);
  text(score, 469, 90);
  if (winning){
    run();
  }
  else{
    text("YOU LOSE YOU SUCK AT THIS GAME", 469, 90);
    activemino.display();
    rect(200, 200, 200, 200);
    noLoop();
  }
}

void run(){
  frame++;
  if(frame%speed == 0){
    frame = 0;
    if(activemino.onBoard(activemino.row+1, activemino.col)){
      activemino.move(0,1);
    }else{
      activemino.transfer();
      activemino = nextmino;
      nextmino = newMino();
      alreadyClickedHeld = false;
      
      if(activemino.overlap()){
        winning = false;
      }
    }
    score += board.clearRows();
  }
}

void keyPressed(){
  if(key == 120){
    activemino.rotate(true);
  }else if(key == 122){
    activemino.rotate(false);
  }
  
  if (keyCode == 37){
    shift(false);
  }else if(keyCode == 39){
    shift(true);
  }else if(keyCode == 40){
    activemino.fastFall();
    activemino = nextmino;
    nextmino = newMino();
    alreadyClickedHeld = false;
  }else if (key == 'c'){
    if (!alreadyClickedHeld){
      if (heldmino == null){
        heldmino = new Tetromino(activemino.getShapeIdent(), new int[]{0,5},board);
        activemino = nextmino;
      }else{
        Tetromino swapTemp = new Tetromino(heldmino.getShapeIdent(), new int[]{0,5},board);;
        heldmino = new Tetromino(activemino.getShapeIdent(), new int[]{0,5},board);
        activemino = swapTemp;
      }
      
      nextmino = new Tetromino(genMino(),new int[]{0,5},board);
      alreadyClickedHeld = true;
    }
  }else if (keyCode == 27 && !winning){
    exit();
  }
}

String genMino(){
  String[] tetrominoidents = new String[]{"o","j","l","z","s","i","t"};
  int idx = (int)(Math.random() * tetrominoidents.length);
  return tetrominoidents[idx];
  //return new Tetromino(tetrominoidents[idx],new int[]{0,5},board);
}

Tetromino newMino(){
  String genIdent = genMino();
  if (genIdent == "i"){
    return new Tetromino(genIdent,new int[] {0,5},board);
  }else{
    return new Tetromino(genIdent,new int[] {0,6},board);
  }
}

void shift(boolean right){
  if(right){
    activemino.move(1,0);
    if (! activemino.onBoard(activemino.row,activemino.col)) activemino.move(-1,0);
  }else{
    activemino.move(-1,0);
    if (! activemino.onBoard(activemino.row, activemino.col)) activemino.move(1,0);
  }
}
  void displayMino(int initcol, int initrow, float[]col,int size){
  float[] colo = new float[3];
  for (int i = 0; i<3; i++){
    colo[i]=col[i]/1.5;
  }
  noStroke();
  fill(color(col[0],col[1],col[2]));
  square(size*initcol, size*initrow, size);
  fill(color(col[0],col[1],col[2]*.8));
  quad(size*initcol,size*initrow,size*initcol,(size*(initrow+1)),(size*initcol)+(size/6),(size*(initrow+1)-(size/6)),(size*initcol)+(size/6),(size*initrow)+(size/6));
  quad(size*(initcol+1),size*initrow,size*(initcol+1),size*(initrow+1),size*(initcol+1)-(size/6),size*(initrow+1)-(size/6),size*(initcol+1)-(size/6),size*(initrow)+(size/6));
  fill(color(col[0],col[1]*.6,col[2]));
  quad(size*initcol,size*initrow, size*(initcol+1),size*(initrow),size*(initcol+1)-(size/6),size*(initrow)+(size/6),size*initcol+(size/6),size*initrow+(size/6));
  fill(color(col[0],col[1],col[2]*.5));
  quad(size*(initcol+1),size*(initrow+1), size*initcol, size*(initrow+1),size*initcol+(size/6), size*(initrow+1)-(size/6),size*(initcol+1)-(size/6),size*(initrow+1)-(size/6));
}
