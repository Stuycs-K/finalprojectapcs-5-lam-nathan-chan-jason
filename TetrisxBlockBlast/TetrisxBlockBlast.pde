void setup(){
  size(450, 720);//finalize the numbers here
}

void draw(){
  int[] initpos = new int[] {7,3};
  Tetromino activemino = new Tetromino("z",initpos);
  Board b = new Board();
  b.display();
  activemino.display();
  //b.clearRows();
  //b.display();
}
