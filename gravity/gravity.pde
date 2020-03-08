ArrayList<Particle> parts = new ArrayList<Particle>();
ArrayList<Particle> attractors = new ArrayList<Particle>();

void setup() {
  background(40);
  size(1000, 1000, P2D);
  //fullScreen();
  for (int i=0; i<0; i++) {
    attractors.add(new Particle(random(width), random(height), random(25, 100), color(#FF525E)));
  }
  //attractors.add(new Particle(mouseX, mouseY, random(25, 150), 150));
}


void draw() {
  background(40);
  for (Particle a : parts) {
    //a.wiggle();    
    a.pather();

    a.move();
    ArrayList<Particle> union = new ArrayList<Particle>();
    union.addAll(attractors);
    union.addAll(parts);
    a.attract(union);

    //a.attract(attractors);
  }

  for (Particle a : attractors) {
    a.show();
    //a.attract(parts);
    //a.wiggle();
  }

  //attractors.get(0).control_pos(mouseX, mouseY);
  //attractors.get(0).attract(parts);
}





void mouseClicked() {
  if (mouseButton == LEFT) {
    attractors.add(new Particle(mouseX, mouseY, 35, color(#FF525E)));
  } else if (mouseButton == RIGHT) {
    parts.add(new Particle(mouseX, mouseY, random(25, 100), color(#48A7ED)));
  } else {
    parts.clear();
    attractors.clear();
  }
}
