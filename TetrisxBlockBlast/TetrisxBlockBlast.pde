private Tetromino activemino;
private Board board;
private int frame = 0, speed = 15;
void setup(){
  size(600, 720);//finalize the numbers here
  int[] initpos = new int[] {3,7};
  board = new Board();
  activemino = new Tetromino("i",initpos,board);
  textSize(48);
  text("Score", 469, 40);
}

void draw(){ 
  board.display();
  activemino.display();
  frame++;
  if(frame == speed){
    frame = 0;
  }
  //b.clearRows();
  //b.display();
  int score = 0;
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
