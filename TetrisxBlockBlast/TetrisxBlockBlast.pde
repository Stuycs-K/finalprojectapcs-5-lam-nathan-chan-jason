private Tetromino activemino, heldmino, nextmino;
private Board board;
private int frame = 0, speed = 15, score = 0;
private int counter = 0;
void setup(){
  background(210);
  size(600, 720);
  fill(0);
  textSize(48);
  text("Score", 469, 40);
  
  int[] initpos = new int[] {0,5};
  board = new Board();
  activemino = new Tetromino(genMino(),new int[]{0,5},board);
  nextmino = new Tetromino(genMino(),new int[]{0,5},board);
}

void draw(){
  background(210);
  text("Score", 469, 40);
  board.display();
  activemino.display();
  fill(0);
  text(score, 469, 90);
  run();
  
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
      nextmino = new Tetromino(genMino(), new int[]{0,5},board);
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
    nextmino = new Tetromino(genMino(),new int[]{0,5},board);
  }
}

String genMino(){
  String[] tetrominoidents = new String[]{"o","j","l","z","s","i"};
  int idx = (int)(Math.random() * tetrominoidents.length);
  return tetrominoidents[idx];
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
