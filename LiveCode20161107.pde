ArrayList<Star> stars = new ArrayList<Star>();

PShape shape;
int COUNT = 200;
int COLOURS = 500;
float RAD = 20;
boolean video = true;

void setup() {
  size(640, 360);
  for (int i = 0 ; i < COUNT ; i++) {
    stars.add(new Star(width / 2, 0));
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
    shape.vertex(RAD * r * cos(TWO_PI * i / 10.0), RAD * r * sin(TWO_PI * i / 10.0));
  }
  shape.endShape(CLOSE);
  colorMode(HSB, COLOURS, 100, 100);
}

void draw() {
  background(0, 0, 0);
  translate(width / 2, 0);
  for (Star star : stars) {
    star.draw();
  }
  if (video) {
    saveFrame("frame#####.png");
    if (frameCount > 500) {
      exit();
    }
  }
}

float ACC = .25;
float VEL = 5;
class Star {
  PVector pos = new PVector();
  PVector vel = new PVector();
  PVector acc = new PVector();
  float r = random(TWO_PI);
  float d = random(-.03, .03);
  int c = (int)random(COLOURS);
  int cd = (int)random(-5, 5);
  
  Star(float x, float y) {
    pos.x = x;
    pos.y = y;
    vel = PVector.random2D().mult(VEL);
    acc.y = ACC;
  }
  
  void draw() {
    r += d;
    c = (c + cd + COLOURS) % COLOURS;
    vel.add(acc);
    pos.add(vel);
    color colour = color(c, 100, 100);
    shape.setStroke(colour);
    noFill();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(r);
    shape(shape);
    popMatrix();
    if (pos.y > height) {
      pos.x = mouseX - width / 2;
      pos.y = mouseY;
      acc.y = ACC;
      vel = PVector.random2D().mult(VEL);
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("snapshot####.png");
  }
}