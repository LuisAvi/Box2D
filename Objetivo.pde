class Atraccion {
  
  Body body1;
  float r;
  color col;

  Atraccion(float r_, float x, float y) {
    r = r_;
    // Definir el body
    makeBody(x, y, r);
    body1.setUserData(this);
    col = color(0,255,0);   
  }
  
  //Composicion de la particula 
   Vec2 atraccion(Particulas m) {
    float G = 70; // Fuerza
    Vec2 pos = body1.getWorldCenter();    
    Vec2 moverPos = m.bodyA.getWorldCenter();
    Vec2 force = pos.sub(moverPos);
    float distance = force.length();
    distance = constrain(distance,1,5);
    force.normalize();
    float strength = (G * 3 * m.bodyA.m_mass) / (distance * distance); 
    force.mulLocal(strength);         
    return force;
   }
  
   void display() {    
    Vec2 pos = box2d.getBodyPixelCoord(body1);   
    float a = body1.getAngle();
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(col);
    noStroke();
    strokeWeight(1);
    ellipse(0,0,r*2,r*2);
    popMatrix();
  }
   
    void makeBody(float x, float y, float r) {
    // Define el body
    BodyDef bd = new BodyDef();
    // Posicion
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.STATIC;
    body1 = box2d.world.createBody(bd);
    
    // Forma del body como circulo
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    
    // Fisicas
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.3;

    // Fixture
    body1.createFixture(fd);    
    body1.setAngularVelocity(0);
  }
}
