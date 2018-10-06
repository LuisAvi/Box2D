class Fin {
  void display(){
      switch(key){
    case '5':
        pantalla = 1;
        break;
    case '6': 
        pantalla = 5;
        break;
    }   
      imageMode(CORNER);
      image(textura1,0,0);
      pushMatrix();{
      scale(0.3,0.3);  
      imageMode(CORNER);
      image(textura2,1280,100);
      }
      popMatrix();
      
      PFont font;
      font = loadFont("Delicious-50.vlw");
      textFont(font, 50);
      fill(255);
      textFont(font, 32);
      text("Haz perdido :'v",40,150);
      text("Suerte para la proxima!",40,200);
      text("Pulsa 5 para volver al inicio!",40,250);
      text("Pulsa 6 para salir!",40,300);    
  }
}
