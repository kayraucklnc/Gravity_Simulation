public class Particle {

  ArrayList<PVector> path = new ArrayList<PVector>();

  static final float k = 500;

  float xoff = random(0, 1000);
  float yoff = random(10000, 40000);


  float x;
  float y;

  color c = color(random(100, 255), random(100, 255), random(100, 255));

  float vx = random(-20, 20);
  float vy = random(-20, 20);

  float ax;
  float ay;

  color col;

  float size;

  //constructors
  public Particle(float x, float y, float s, color c) {
    this.x = x; 
    this.y = y;
    this.size = s;
    this.col = c;
  }

  public Particle(float x, float y, float s) {
    this(x, y, s, 255);
  }

  public Particle(float x, float y) {
    this(x, y, 30, 255);
  }
  //ends


  public void control_pos(float x, float y) {
    this.x=x;
    this.y=y;
    show();
  }

  public void wiggle() {
    this.x=1000*noise(xoff);
    this.y=1000*noise(yoff);

    this.x = constrain(this.x, 0, width);
    this.y = constrain(this.y, 0, height);

    xoff += map(this.size, 25, 150, 0.01, 0);
    yoff += map(this.size, 25, 150, 0.01, 0);
    show();
  }

  public void pather() {
    push();
    strokeWeight(6);
    noFill();
    stroke(255);
    beginShape();
    for (int i=path.size()-1; i>0; i--) {
      vertex(path.get(i).x, path.get(i).y);
    }
    endShape();
    pop();
  }

  public void show() {
    push();
    fill(col);
    ellipse(this.x, this.y, this.size, this.size);
    if (path.size()>40) {
      path.remove(0);
    }   
    path.add(new PVector(this.x, this.y));


    pop();
  }


  public void attract(ArrayList<Particle> list) {
    PVector temp = new PVector();
    for (Particle other : list) {
      if (other != this) {      
        PVector ovec = new PVector(other.x, other.y);
        PVector tvec = new PVector(this.x, this.y);

        PVector unit = ovec.sub(tvec).normalize();
        unit.mult(this.calculate(this, other));
        unit.mult(k).limit(200);

        push();
        stroke(#EAFF08);
        strokeWeight(7);
        //line(this.x, this.y, 3*this.vx+this.x, 3*this.vy+this.y);        
        pop();

        unit.div(this.size);

        temp.add(unit);
      }
    }
    this.ax = (temp.x);
    this.ay = (temp.y);
    push();
    translate(this.x, this.y);
    stroke(#00FA48);
    strokeWeight(6);
    //line(0, 0, 20*temp.x, 20*temp.y);
    pop();

    //this.ax = constrain(this.ax, -10, 10);
    //this.ay = constrain(this.ay, -10, 10);
  }

  public void move() {
    this.vx += this.ax;
    this.vy += this.ay;

    this.vx = constrain(this.vx, -60, 60);
    this.vy = constrain(this.vy, -60, 60);

    this.x += this.vx;
    this.y += this.vy;


    this.borders();

    this.show();
  }

  public void borders() {
    //if (this.x<-this.size) {
    //  this.x = width+this.size;
    //}
    //if (this.x-this.size>width) {
    //  this.x = -this.size;
    //}
    //if (this.y-this.size>height) {
    //  this.y = -this.size;
    //}
    //if (this.y<-this.size) {
    //  this.y = height+this.size;
    //}



  //  if (this.x<-this.size) {
  //    this.x = -this.size;
  //  }
  //  if (this.x>width+this.size) {
  //    this.x = width+this.size;
  //  }
  //  if (this.y>height+this.size) {
  //    this.y = height+this.size;
  //  }
  //  if (this.y<-this.size) {
  //    this.y = -this.size;
  //  }
  //}
  
      if (this.x<0) {
      this.vx *= -0.7;
    }
    if (this.x>width) {
      this.vx *= -0.7;
    }
    if (this.y>height) {
      this.vy *= -0.7;
    }
    if (this.y<0) {
      this.vy *=-0.7;
    }
  }




  public float calculate(Particle a, Particle b) {
    return ( (a.size*b.size) / pow(dist(a.x, a.y, b.x, b.y), 2) );
  }
}
