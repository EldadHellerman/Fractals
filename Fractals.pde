/*
* A program that generated fractals.
* It is very messy - I just quickly wrote it to get some beautiful results.
* you can visit my website to read a blog article about it, link in my profiles README file.
* A mandelbrot set zoom in can be seen in the video.
*/

final int MAX_ITERATIONS = 20;//20 
final int MAX_ITERATIONS_NEWTON = 100;
final int MAX_ZOOM = 20; //850
double pointX, pointY;

PImage fractal[];
int zoom = 0;

double map(double v, double min, double max, double to_min, double to_max) {
  double r = (v-min)*(to_max-to_min)/(max - min) + to_min;
  return r;
}


void setup() {
  size(1000, 1000);
  fractal = new PImage[MAX_ZOOM];
  for (int i=0; i<MAX_ZOOM; i++) {
    fractal[i] = new PImage(width,height,RGB);
  }
  //computeFractals();
  computeFractalsNewton();
}

void computeFractals(){
  //colorMode(HSB, 255);
  colorMode(RGB, 255);
  //pointX = 0.30020317d; pointY = 0.025862921d; //Mandelbrot
  //pointX = -1.787572145340d; pointY = -0.00953511893612d; //Burning ship
  pointX = -1.56d; pointY = -0.0030d; //Burning ship 2
  
  PImage img = new PImage(width, height, RGB);
  for (int zoom_level=0; zoom_level<MAX_ZOOM; zoom_level++) {
    //for(int zoom_level=850; zoom_level<MAX_ZOOM; zoom_level++){
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        double s = 1/pow(3, zoom_level-1); //half window size
        double f_x = map(x, 0, width, pointX-s, pointX+s);
        double f_y = map(y, 0, height, pointY-s, pointY+s);
        Complex constant = new Complex(f_x, f_y);
        //double l = iterations(constant, MAX_ITERATIONS);
        //MAX_ITERATIONS = 20;
        int iter = MAX_ITERATIONS*(zoom_level/4+1);
        //int iter = MAX_ITERATIONS + (zoom_level*3);
        double l = iterations_burning_ship(constant, iter);
        color c = color(0, 0, 0);
        if (l != 0) {
          //mandelbrot: (length after escape)
          //colorMode(HSB, 255);
          //int r = (int)map(l, 2, 10, 255, 0);
          //r %= 255;
          //c = color(r, 255, 255);
          //
          //mandelbrot 2: (iterations number)
          //colorMode(RGB, 255);
          //int r = (int)map(l, 2, 15, 0, 255);
          //c = color(r,0,0);
          //
          //for burning ship use max iteration of ~64-200
          //burning ship 1:
          //colorMode(HSB, 255);
          //int r = (int)map(l, 2, iter, 255, 0);
          //c = color(r, 255, 255);
          //
          //burning ship 2:
          colorMode(RGB, 255);
          int r = (int)map(l, 2, iter, 0, 255);
          c = color(r, 0, 0);
          //
        }
        img.set(x, y, c);
        fractal[zoom_level].set(x, y, c);
      }
    }
    img.save(savePath("output/burning ship/" + zoom_level + ".png"));
    println(zoom_level + " / " + MAX_ZOOM);
  }
  //print("done");
}

double abs(double x){
  return x >= 0 ? x : -x;
}

color gradient(color c, float g){
  colorMode(RGB, 255);
  return color(red(c)*g, green(c)*g, blue(c)*g);
}

void computeFractalsNewton(){
  double tolerance = 0.0001;
  //double tolerance = 0.1;
  /*
  p(z) = z^3 + 1
  //pointX = -0.189013937657097d; pointY = -0.120d;
  color[] colors = {0xff0000, 0x00ff00, 0x0000ff};
  Complex[] roots = {  new Complex(1,0),
                       new Complex(-0.5,sqrt(3)/2),
                       new Complex(-0.5,-sqrt(3)/2),
                       new Complex(-0.2,sqrt(5)/2),
                       new Complex(-0.2,-sqrt(5)/2)};
  Complex[] c1 = {  new Complex(1,0),
                   new Complex(0,0),
                   new Complex(0,0),
                   new Complex(-1,0)};
  Polynom p = new Polynom(c1);
  Polynom p2 = new Polynom(0);
  p2.create_from_roots(roots);
  //println("original p is: ", p.str());
  //println("original p2 is: ", p2.str());
  */
  
  /*
  //p(z) = z^8 + 15z^4 − 16
  double sqrt2 = sqrt(2);
  Complex[] c2 = {  new Complex(1,0), new Complex(0,0), new Complex(0,0), new Complex(0,0),
                    new Complex(15,0), new Complex(0,0), new Complex(0,0), new Complex(-16,0)};
  Complex[] roots = {new Complex(1,0), new Complex(-1,0), new Complex(0,1), new Complex(0,-1),
                    new Complex(-sqrt2,-sqrt2), new Complex(-sqrt2,sqrt2), new Complex(sqrt2,-sqrt2), new Complex(sqrt2,sqrt2)};
  color[] colors = {#DB286D, #8A28DB, #289EDB, #28DB50,
                    #D4D661, #E3764E, #2D82A0, #FF08AD};
  //pointX = -0.5560d; pointY = -0.008367d;
  */
  /*
  //p(z) = z^6 + z^3 − 1
  pointX = -0.586d; pointY = -0.308367d;
  Complex[] c2 = {  new Complex(1,0), new Complex(0,0), new Complex(0,0), new Complex(1,0),
                    new Complex(0,0), new Complex(0,0), new Complex(-1,0)};
  Complex[] roots = {new Complex(-1.17398499670533,0), new Complex(0.851799642079243,0),
                    new Complex(0.586992498352664,1.016700830808605), new Complex(-0.425899821039621,0.737680128975117),
                    new Complex(0.586992498352664,-1.016700830808605), new Complex(-0.425899821039621,-0.737680128975117)};
  color[] colors = {#DB286D, #8A28DB, #289EDB, #28DB50,
                    #D4D661, #E3764E, #2D82A0, #FF08AD};
  */
  
  pointX = -0.305259258d; pointY = -0.2718433d;
  Complex[] c2 = {  new Complex(1,0), new Complex(0,0), new Complex(0,-3),
                    new Complex(-5,-2), new Complex(3,0), new Complex(1,0)};
  Complex[] roots = {  new Complex(-1.28991840489623d,-1.87356959822921d),
                       new Complex(-0.82485325744088d,1.17352878781554d),
                       new Complex(-0.237440220341105d,+0.013472889556552d),
                       new Complex(0.573867932986824d,-0.276869135501157d),
                       new Complex(1.77834394969139d,0.96343705635828d)};
  color[] colors = {#474A51, #D95030, #E6D690, #606E8C, #721422};
                    
  Polynom p = new Polynom(c2);
  
  //colorMode(HSB, 255);
  colorMode(RGB, 255);
  PImage img = new PImage(1000, 1000, RGB);
  for (int zoom_level=0; zoom_level<MAX_ZOOM; zoom_level++) {
    //for(int zoom_level=23; zoom_level<MAX_ZOOM; zoom_level++){
    Result result = null;
    int iter = MAX_ITERATIONS + (zoom_level*5);
    //int iter = MAX_ITERATIONS + zoom_level*2;
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        double s = 1/pow(3, zoom_level-1); //half window size
        double f_x = map(x, 0, width, pointX-s, pointX+s);
        double f_y = map(y, 0, height, pointY-s, pointY+s);
        result = approx_root(p, new Complex(f_x, f_y), iter, tolerance);
        Complex r = result.root;
        color clr = color(20);
        /*
        for(int i=0; i<colors.length; i++){
          double distance_squared = (r.x - roots[i].x)*(r.x - roots[i].x) + (r.y - roots[i].y)*(r.y - roots[i].y); 
          if(distance_squared < tolerance){
            float grad = (float)map(result.iterations, 0, iter/2, 0,1);
            clr = gradient(colors[i],grad);
            clr = colors[i];
          }
        }*/
        double min_dist = 500;
        for(int i=0; i<roots.length; i++){
          double distance_squared = (r.x - roots[i].x)*(r.x - roots[i].x) + (r.y - roots[i].y)*(r.y - roots[i].y);
          if(distance_squared < min_dist){
            min_dist = distance_squared;
            //float grad = (float)map(distance_squared, 0, 1, 0.3 ,1);
            float grad = (float)map(result.iterations, 0, iter/2, 0,1);
            clr = gradient(colors[i], grad);
            //clr = colors[i];
          }
        }
        
        img.set(x, y, clr);
        fractal[zoom_level].set(x, y, clr);
      }
    }
    //if(result != null) println(result.iterations + "iteration out of " + iter);
    img.save(savePath("output/newton 7/" + zoom_level + ".png"));
    println(zoom_level + " / " + MAX_ZOOM);
  }
  //print("done");
}

void draw_mouse_coordinants(){
  stroke(255, 255, 255);
  line(500, 0, 500, 1000);
  line(0, 500, 1000, 500);
  textSize(50);
  double s = 1/pow(3, zoom-1); //half window size
  int x = coordinants_frozen ? frozen_mouse_x : mouseX;
  int y = coordinants_frozen ? frozen_mouse_y : mouseY;
  double f_x = map(x, 0, width, pointX-s, pointX+s);
  double f_y = map(y, 0, height, pointY-s, pointY+s);
  if(coordinants_frozen) fill(255,0,0);
  text(f_x + ", " + f_y, 20, 90);
}

void draw() {
  background(0);
  image(fractal[zoom], 0, 0);
  text(zoom, 20, 40);
  textSize(50);
  draw_mouse_coordinants();
}

double iterations(Complex constant, int maxIterations) {
  int iteration_number;
  Complex v = new Complex(0, 0);
  for (iteration_number=0; iteration_number < maxIterations; iteration_number++) {
    v.multiply(v);
    v.add(constant);
    //if (v.length_squared() > 4) return(v.length_squared());
    if(v.length_squared() > 4) return(iteration_number);
  }
  //println(iteration_n umber);
  return(0);
}

double iterations_burning_ship(Complex constant, int maxIterations) {
  Complex v = new Complex(0, 0);
  for (int iteration_number=0; iteration_number < maxIterations; iteration_number++) {
    v.absXY(); v.multiply(v); v.add(constant);
    double l = v.length_squared(); 
    //if(l > 4) return(l);
    //if(v.length_squared() > 4) return(iteration_number);
    if(l > 4) return(iteration_number);
  }
  return(maxIterations);
}

boolean coordinants_frozen = false;
int frozen_mouse_x, frozen_mouse_y;
void mouseClicked(){
  coordinants_frozen ^= true;
  frozen_mouse_x = mouseX;
  frozen_mouse_y = mouseY;
}

void mouseWheel(MouseEvent event) {
  zoom -= (int)event.getCount();
  if (zoom < 0) zoom = 0;
  if (zoom >= MAX_ZOOM) zoom = MAX_ZOOM-1;
}
