public class Result{
  /*
  * A class to perform newtons method
  */
  public Complex root;
  public int iterations;
  
  Result(Complex z, int iter){
    this.root = z;
    this.iterations = iter;
  }
};

Result approx_root(Polynom poly, Complex initial,int iterations, double tolerance){
  Complex root = new Complex(initial.x, initial.y);
  Polynom derivative = poly.derivative();
  //println("Polynom is: " + poly.str());
  //println("Derivative is: " + derivative.str());
  
  //Complex r = poly.evaluate(new Complex(2,0));
  //println("polynom at (2,0) is " + r.str());
  Complex p = new Complex(0,0);
  int i=0;
  for(; i<iterations; i++){
    Complex c = poly.evaluate(root);
    Complex der = derivative.evaluate(root);
    if(der.x == 0 && der.y == 0) break;
    c.divide(der);
    root.subtract(c);
    if(abs(p.x - root.x) < tolerance && abs(p.y - root.y) < tolerance) break;
    p.x = root.x;
    p.y = root.y;
  }
  return(new Result(root,i));
}
