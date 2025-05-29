void setup(){
  size(420, 724);//finalize the numbers here
}

void draw(){
  Board b = new Board();
  for(int i = 0; i < 12; i++){
    b.setmino(new int[]{i, 0}, 1);
  }
  b.display();
  //b.clearRows();
  //b.display();
}
