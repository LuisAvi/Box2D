/* Este proyecto esta basado en distintos ejemplos proporcionados 
en las librerias de Box2D, así como la librería para la musica use "Minim" ya que el
convencional marcaba un error. Como nota, al correr el juego hay que primero dar clic en
ventana que se genera ya que la funcion que mueve al jugador se basa en la posición del 
mouse y si antes de iniciar no se da clic en la pantalla del juego éste no aparecera
sino hasta dejar presionado el mouse ya que toma la posicion que el mouse tiene en
ese momento.
Los archivos pacman.png, triste.png, space.png, Shooting Stars.mp3 y la tipografia Delicious-50.vlw se encuentran en el repositorio
del GitHub, que van en la carpeta "data".
*/
//Se esta usando la libreria box2d que continuacion se llaman
import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import ddf.minim.*;

//Referencia del mundo box2D
Box2DProcessing box2d;

//Clases y variables
Particulas[] particulas = new Particulas[15];
Atraccion a;
Box box;
Inicio inicio;
Instruccion instruccion;
Fin fin;

//Musica
Minim minim;
AudioPlayer player;

PImage textura, textura1, textura2;
int pantalla = 1;

void setup() {
  size(640,360);
  smooth();
  
  //Imagenes
  textura = loadImage("pacman.png");
  textura1 = loadImage("space.png"); 
  textura2 = loadImage("triste.png");
  
  //Box2D
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,0);
  
  //Musica
  minim = new Minim(this);
  player = minim.loadFile("Shooting Stars.mp3", 2048);
  player.play();
  
  // Activar las colisiones del objetivo y el enemigo
  box2d.listenForCollisions();

  // Crea la caja
  box = new Box(width/2,height/2);
  inicio = new Inicio();
  instruccion = new Instruccion();
  fin = new Fin();
  
  for (int i = 0; i < particulas.length; i++) {
    particulas[i] = new Particulas(random(width),random(height));
  }
  a = new Atraccion(32,width/2,height/2);
}

void draw() {
  background(255);
   switch(pantalla){
    case 1: 
      inicio.display();
      break;
    case 2:
      instruccion.display();
      break;
    case 3:
      imageMode(CORNER);
      image(textura1,0,0);
      a.display();
      box.display();
       for (int i = 0; i < particulas.length; i++) {  
       Vec2 force = a.atraccion(particulas[i]);
       particulas[i].applyForce(force);
       particulas[i].display();
       }       
       break;      
    case 4:
       fin.display();
       break;
    case 5: 
        exit();
        
  } 
  
  box2d.step();
    
  if (mousePressed) {
    box.setposition(mouseX,mouseY);
  } else {
    
  } 
}

void beginContact(Contact cp) {
  
  // Ambas fixture
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  
  // Ambos body
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();
 
  // Objetos referenciados a body
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  // Cambio y paso a la pantalla de resolucion
   if (o2.getClass() == Atraccion.class) {
    Particulas p = (Particulas) o1;
    p.change();
    pantalla = 4;
  }
}
void endContact(Contact cp) {
  
}
void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
