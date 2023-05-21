public class Polynom{
  /*
  * A class to represent polynomials.
  */
  public int degree;
  public Complex[] coefficients;
  
  public Polynom(Complex[] coefficients){
    this.degree = coefficients.length;
    this.coefficients = coefficients;
  }
  
  public Polynom(int degree){
    this.degree = degree;
    this.coefficients = new Complex[degree];
    for(int i=0; i<degree; i++) coefficients[i] = new Complex(0, 0);
  }
  
  public Polynom derivative(){
    Polynom result = new Polynom(this.degree - 1);
    for(int i=0; i<degree-1; i++) result.coefficients[i] = new Complex((i+1) * coefficients[i+1].x, (i+1) * coefficients[i+1].y);
    return result;
  }
  
  public Complex evaluate(Complex x){
    Complex result = new Complex(0,0);
    for(int i=0; i<degree; i++){
      //print("degree " + i);
      Complex temp = new Complex(x.x, x.y);
      temp.power(i);
      temp.multiply(coefficients[i]);
      //print("---multily with " + coefficients[i].str() + " is " + temp.str() + "---");
      //println(" addedd - " + temp.str());
      result.add(temp);
    }
    return(result);
  }
  
  public String str(){
    String s = "";
    for(int i=degree; i>0; i--){
      s += "(" + coefficients[i-1].x + " + i" + coefficients[i-1].y + ")";
      if(i != 1) s+= "*x^" + (i-1) + " + ";
    }
    return(s);
  }
  
  public void create_from_roots(Complex[] roots){
    int deg = roots.length + 1;
    Polynom result = new Polynom(deg);
    println("degeree: ", deg);
    result.coefficients[0] = new Complex(1,0);
    result.coefficients[1] = new Complex(-roots[0].y, -roots[0].y);
    for(int r=1; r<=deg-1; r++){
      for(int c=deg-1; c>0; c--) result.coefficients[c] = result.coefficients[c - 1];
      for(int c=deg-1; c>0; c--){
        Complex cf = result.coefficients[c];
        Complex rt = roots[r-1];
        Complex temp = new Complex(cf.x, cf.y);
        print(temp.str() + "-----");
        temp.multiply(new Complex(-rt.x, -rt.y));
        result.coefficients[c-1].add(temp);
      }
    }
    this.coefficients = result.coefficients;
    this.degree = result.degree;
  }
}
