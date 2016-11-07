ArrayList<Star> stars = new ArrayList<Star>();

PShape shape;
int COUNT = 2;
int COLOURS = 500;

void setup() {
  size(640, 360);
  for (int i = 0 ; i < COUNT ; i++) {
    stars.add(new Star(width / 2, height / 2));
  }
  shape = createShape();
  shape.beginShape();
  shape.noFill();
  shape.stroke(255);
  for (int i = 0 ; i < 10 ; i++) {
    float r = 1.0;
    if ((i & 1) == 0) {
      r = .35;
    }
    shape.vertex(r * cos(TWO_PI * i / 10.0), r * sin(TWO_PI * i / 10.0));
  }
  shape.endShape(CLOSE);
  colorMode(HSB, COLOURS, 100, 100);
}

void draw() {
  background(0, 0, 0);
  for (Star star : stars) {
    star.draw();
  }
}

class Star {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float r = random(TWO_PI);
  float d = random(-.02, .02);
  int c = (int)random(COLOURS);
  int cd = (int)random(-5, 5);
  
  Star(float x, float y) {
    pos.x = x;
    pos.y = y;
    vel = PVector.random2D();
    acc.y = -.5;
  }
  
  void draw() {
    r += d;
    c = (c + cd + COLOURS) % COLOURS;
    vel.add(acc);
    pos.add(vel);
    stroke(c);
    noFill();
    pushMatrix();
    rotate(r);
    translate(pos.x, pos.y);
    shape(shape);
    popMatrix();
  }
}