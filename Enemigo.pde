class Particulas{
  Body bodyA;
  float x, y;
  color col;
  Particulas (float x, float y){
    //Caja en el mundo box2d
    makeBody(new Vec2(x,y));
    bodyA.setUserData(this);
    col = color(255,0,0); 
  }
  void change() {
    col = color(255);
  }
  void applyForce(Vec2 v){
    bodyA.applyForce(v, bodyA.getWorldCenter());
  }
  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(bodyA);
    // Da angulo de rotacion
    float a = bodyA.getAngle();

    Fixture f = bodyA.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
 
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    noStroke();
    beginShape();
    for (int i = 0; i < ps.getVertexCount(); i++) {
      Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i));
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
    popMatrix();
  }
  void makeBody(Vec2 center) {

    // Define el poligono
    PolygonShape sd = new PolygonShape();

    Vec2[] vertices = new Vec2[4];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(-15, 25));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(15, 0));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(20, -15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-10, -10));

    sd.set(vertices, vertices.length);

    // Define el body y lo hace forma
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    //Posicion
    bd.position = box2d.coordPixelsToWorld(random(0,640),-100);
    bodyA = box2d.createBody(bd);

    bodyA.createFixture(sd, 1.0);
    
    // Velocidad inicial random
    bodyA.setLinearVelocity(new Vec2(random(-.5, .5), random(-.5, .5)));
    bodyA.setAngularVelocity(0);
  }
} 
