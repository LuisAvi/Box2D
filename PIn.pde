class Inicio {
     
    void display(){
     switch(key){
    //Jugar
    case '1':
        pantalla = 2;
        break;
    //Salir
    case '2':
        exit();
        break;
  }
      imageMode(CORNER);
      image(textura1,0,0);
      PFont font;
      font = loadFont("Delicious-50.vlw");
      textFont(font, 60);
      fill(255);
      text("POP UP!", 65, 150);
      textFont(font, 32);
      text("Presiona 1 para comenzar!",100,250);
      text("Presiona 2 para salir!",200,300);
    }
    
  }
