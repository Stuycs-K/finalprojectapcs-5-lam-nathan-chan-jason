void setup(){
  size(420, 724);//finalize the numbers here
}

void draw(){
  int[] initpos = new int[] {6,30};
  Tetromino activemino = new Tetromino("i",initpos);
  Board b = new Board();
  b.display();
<<<<<<< HEAD
  b.clearRows();
  b.display();
=======
  activemino.display();
  //b.clearRows();
  //b.display();
>>>>>>> 8647d4aaec864878b0099b054859b71d7e27de00
}
