private Tetromino activemino;
private Board board;
void setup(){
  size(450, 720);//finalize the numbers here
  int[] initpos = new int[] {7,3};
  activemino = new Tetromino("z",initpos,board);
  board = new Board();
}

void draw(){ 
  board.display();
  activemino.display();
  //b.clearRows();
  //b.display();
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
  }else{
    activemino.move(-1,0);
  }
  
}
