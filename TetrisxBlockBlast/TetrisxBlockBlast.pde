private Tetromino activemino;
private Board board;
private int frame = 0, speed = 15, score = 0;
void setup(){
  background(210);
  size(600, 720);
  fill(0);
  textSize(48);
  text("Score", 469, 40);
  
  int[] initpos = new int[] {3,7};
  board = new Board();
  activemino = new Tetromino("i",initpos,board);
  
  /*for (int i = 0; i < 15; i++){
    board.setmino(new int[]{i, 0}, 1);
  }
  board.setmino(new int[]{0, 0}, 1);
  board.setmino(new int[]{0, 23}, 1);*/
}

void draw(){
  background(210);
  text("Score", 469, 40);
  
  board.display();
  activemino.display();
  frame++;
  if(frame == speed){
    frame = 0;
  }
  score += board.clearRows();
  
  fill(0);
  text(score, 469, 90);
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
  }
}

void shift(boolean right){
  if(right){
    activemino.move(1,0);
    if (! activemino.onBoard()) activemino.move(-1,0);
  }else{
    activemino.move(-1,0);
    if (! activemino.onBoard()) activemino.move(1,0);
  }
  
}
