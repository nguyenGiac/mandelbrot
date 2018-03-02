// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// The Mandelbrot Set

// Simple rendering of the Mandelbrot set
// c = a + bi
// Iterate z = z^2 + c, i.e.
// z(0) = 0
// z(1) = 0*0 + c
// z(2) = c*c + c
// z(3) = (c*c + c) * (c*c + c) + c
// etc.

// c*c = (a+bi) * (a+bi) = a^2 - b^2 + 2abi

// Establish a range of values on the complex plane
double xmin = -2.5; 
double ymin = -1; 
double w = 4; 
double h = 2;
float r,g,b,incr;

void setup() {
  size(800,400);
  incr = .05;
  mandelbrot();
}

void draw() {
  zoomIn();
  mandelbrot();
  //saveFrame("####.jpg");
}

void mandelbrot(){
    loadPixels();
  
  // Maximum number of iterations for each point on the complex plane
  int maxiterations = 200;

  // x goes from xmin to xmax
  double xmax = xmin + w;
  // y goes from ymin to ymax
  double ymax = ymin + h;
  
  // Calculate amount we increment x,y for each pixel
  double dx = (xmax - xmin) / (width);
  double dy = (ymax - ymin) / (height);

  // Start y
  double y = ymin;
  for(int j = 0; j < height; j++) {
    // Start x
    double x = xmin;
    for(int i = 0;  i < width; i++) {
      
      // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
      double a = x;
      double b = y;
      int n = 0;
      while (n < maxiterations) {
        double aa = a * a;
        double bb = b * b;
        double twoab = 2.0 * a * b;
        a = aa - bb + x;
        b = twoab + y;
        // Infinty in our finite world is simple, let's just consider it 16
        if(aa + bb > 16.0f) {
          break;  // Bail
        }
        n++;
      }
      
      // We color each pixel based on how long it takes to get to infinity
      // If we never got there, color it white
      if (n == maxiterations) pixels[i+j*width] = color(255);
      else pixels[i+j*width] = color((n*12)%255);
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}

void zoomIn(){
  if(w-incr > 0){
    w -= incr;
    if(h-(incr/2) > 0){
      h -= incr/2;
      xmin += incr/4;
      ymin += incr/4;
    } else {
       incr *= .98749999; // we shrink the incrementer so that the movement isn't jumpy as we zoom
    }
  } else {
   incr *= .98749999;
  }
  incr *= .98749999;

}
