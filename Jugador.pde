class Box {
  
  Body body;
  float w;
  float h;
  
  boolean dragged = false;

  // Constructor
  Box(float x_, float y_) {
    float x = x_;
    float y = y_;
    w = 24;
    h = 24;
    // Añadir al jugador al mundo de box2d
    makeBody(new Vec2(x,y),w,h);    
  }
  
  void killBody() {
    box2d.destroyBody(body);
  }

  boolean contains(float x, float y) {
    Vec2 worldPoint = box2d.coordPixelsToWorld(x, y);
    Fixture f = body.getFixtureList();
    boolean inside = f.testPoint(worldPoint);
    return inside;
  }
  
  void setAngularVelocity(float a) {
    body.setAngularVelocity(a); 
  }
  void setVelocity(Vec2 v) {
     body.setLinearVelocity(v);
  }
  
  void setposition(float x, float y) {
    Vec2 pos = body.getWorldCenter();
    Vec2 target = box2d.coordPixelsToWorld(x,y);
    Vec2 diff = new Vec2(target.x-pos.x,target.y-pos.y);
    diff.mulLocal(50);
    setVelocity(diff);
    setAngularVelocity(0);
  }

  // Hacer al jugador
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Poner angulo de rotacion
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(a);
    fill(0);
    noStroke();
    imageMode(CENTER);
    scale(.5,.5);
    image(textura,w,h);
    popMatrix();
  }


  // Esto añade al jugador al mundo
  void makeBody(Vec2 center, float w_, float h_) {
    // Define and create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    bd.fixedRotation = true;
    body = box2d.createBody(bd);

    // Define el poligono)
    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    ps.setAsBox(box2dW, box2dH);

    // Define la fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Parametros que afectan la fisica
    fd.density = 1;
    fd.friction = .5;
    fd.restitution = .5;

    body.createFixture(fd);
  }
}
