private Tetromino activemino, heldmino, nextmino;
private String[] bucket;
private int bucketplace = 0;
private Board board;
private int frame = 0, speed = 15, score = 0;
private boolean alreadyClickedHeld, winning;

public Hashtable<String, float[]> colors = new Hashtable<String, float[]>();
  final float[] empt = {0,0,20,100};
  final float[] ci = new float[]{180,100,100,100};
  final float[] co = new float[]{50,100,100,100};
  final float[] cl = new float[]{39,100,100,100};
  final float[] cj = new float[]{240,100,100,100};
  final float[] cs = new float[]{120,100,100,100};
  final float[] cz = new float[]{0,100,100,100};
  final float[] ct = new float[]{277,100,85,100};

public Hashtable<Integer,String> colorRef = new Hashtable<Integer,String>();

void setup(){
  colorMode(HSB,360,100,100,100);
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
  bucket = genBucket();
  activemino = newMino(bucket[bucketplace]);
  nextmino = newMino(bucket[bucketplace+1]);
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
  activemino.displayGhost();
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
    activemino.display();
    fill(210);
    stroke(130);
    strokeWeight(10);
    rect(50, 250, 350, 175);
    fill(0);
    text("You Lose! Sucks!", 60, 300);
    text("Press ESC to exit", 60, 350);
    text("and cry!", 150, 400);
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
      progressMinoes();
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
    progressMinoes();
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
      progressMinoes();
      alreadyClickedHeld = true;
    }
  }else if (keyCode == 27 && !winning){
    exit();
  }
}
String[] genBucket(){
  ArrayList<String> tetrominoidents = new ArrayList<String>();
  tetrominoidents.add("i");
  tetrominoidents.add("o");
  tetrominoidents.add("l");
  tetrominoidents.add("j");
  tetrominoidents.add("s");
  tetrominoidents.add("z");
  tetrominoidents.add("t");
  String[] bucket = new String[tetrominoidents.size()];
  int i = 0;
  while (tetrominoidents.size()>0){
    int idx = (int)(Math.random()*tetrominoidents.size());
    bucket[i] = tetrominoidents.get(idx);
    i++;
    tetrominoidents.remove(idx);
  }
  return bucket;
}

void progressMinoes(){
  bucketplace++;
  if (bucketplace == 6){
    bucketplace = -1;
    bucket = genBucket();
  }
  nextmino = newMino(bucket[bucketplace+1]);
}

String genMino(){
  String[] tetrominoidents = new String[]{"o","j","l","z","s","i","t"};
  int idx = (int)(Math.random() * tetrominoidents.length);
  return tetrominoidents[idx];
}

Tetromino newMino(String ident){
  if (ident == "i"){
    return new Tetromino(ident,new int[] {0,5},board);
  }else{
    return new Tetromino(ident,new int[] {0,6},board);
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
  void displayMino(int initcol, int initrow, float[]col,int size, boolean fade){
  float[] colo = new float[4];
  for (int i = 0; i<4; i++){
    colo[i]=col[i];
  }

  noStroke();
  fill(color(colo[0],colo[1],colo[2],colo[3]));
  if(!fade){
    square(size*initcol, size*initrow, size);
    fill(color(colo[0],colo[1],colo[2]*.8,colo[3]));
  }
  quad(size*initcol,size*initrow,size*initcol,(size*(initrow+1)),(size*initcol)+(size/6),(size*(initrow+1)-(size/6)),(size*initcol)+(size/6),(size*initrow)+(size/6));
  quad(size*(initcol+1),size*initrow,size*(initcol+1),size*(initrow+1),size*(initcol+1)-(size/6),size*(initrow+1)-(size/6),size*(initcol+1)-(size/6),size*(initrow)+(size/6));
  fill(color(colo[0],colo[1]*.6,colo[2],colo[3]));
  quad(size*initcol,size*initrow, size*(initcol+1),size*(initrow),size*(initcol+1)-(size/6),size*(initrow)+(size/6),size*initcol+(size/6),size*initrow+(size/6));
  if(!fade)fill(color(colo[0],colo[1],colo[2]*.5,colo[3]));
  quad(size*(initcol+1),size*(initrow+1), size*initcol, size*(initrow+1),size*initcol+(size/6), size*(initrow+1)-(size/6),size*(initcol+1)-(size/6),size*(initrow+1)-(size/6));
}
