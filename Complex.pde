class Complex{
  /*
  * A class for complex numbers
  */
  public double x, y;
  
  public Complex(double x, double y){
   this.x = x;
   this.y = y;
  }
  
  public Complex(int x, int y){
    this((double)x, (double)y);
  }
  
  public double length_squared(){
    return(x*x + y*y);
  }
  
  public void multiply(Complex c){
    double n_x = x*c.x - y*c.y;
    double n_y = y*c.x + x*c.y;
    x = n_x;
    y = n_y;
  }
  
  public void divide(Complex c){
    multiply(c.conjugate());
    double s = Math.pow(c.x,2) + Math.pow(c.y,2);
    x /= s;
    y /= s;
  }
  
  public void add(Complex c){
    x += c.x;
    y += c.y;
  }
  
  public void subtract(Complex c){
    x -= c.x;
    y -= c.y;
  }
  
  public void absXY(){
    if(x < 0) x = -x;
    if(y < 0) y = -y;
  }
  
  public void power(int pow){
    if(pow == 0){
      this.x = 1;
      this.y = 0;
    }
    Complex temp = new Complex(x,y);
    for(int i=1; i<pow; i++){
      this.multiply(temp);
    }
  }
  public Complex conjugate(){
    return new Complex(x,-y);
  }
  public String str(){
    return("C(" + x + " + i" + y + ")");
  }
}
