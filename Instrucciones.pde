class Instruccion{
  void display(){
    imageMode(CORNER);
    image(textura1,0,0);   
    PFont font;
      font = loadFont("Delicious-50.vlw");
      textFont(font, 50);
      fill(255);
      text("INTRUCCIONES!", 40, 100);
      textFont(font, 32);
      text("Manten Presionado el Mouse",40,150);
      text("para que aparezca el heroe!",40,200);
      text("Salva al verde!",40,250);
      text("Pulsa 3!",40,300);
      switch(key){
    //Jugar
    case '3':
        pantalla = 3;
        break;
    }
  }
}
