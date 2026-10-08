Function[{a1, a2, a3, a4, a5, a6, b1, b2, b3, b4, b5}, 
 {HypExp`Private`PZ[6, 1, {1}] -> a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - 
    b3 - b4 - b5, HypExp`Private`PZ[6, 2, {2}] -> 
   a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
    a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
    a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
    a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
    a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
    a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
    (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2, 
  HypExp`Private`PZ[6, 2, {1, 1}] -> (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - 
     b3 - b4 - b5)^2, HypExp`Private`PZ[6, 3, {3}] -> 
   a3*a4*a5 + a3*a4*a6 + a3*a5*a6 + a4*a5*a6 - a3*a4*b1 - a3*a5*b1 - 
    a4*a5*b1 - a3*a6*b1 - a4*a6*b1 - a5*a6*b1 + a3*b1^2 + a4*b1^2 + a5*b1^2 + 
    a6*b1^2 - b1^3 - a3*a4*b2 - a3*a5*b2 - a4*a5*b2 - a3*a6*b2 - a4*a6*b2 - 
    a5*a6*b2 + a3*b1*b2 + a4*b1*b2 + a5*b1*b2 + a6*b1*b2 - b1^2*b2 + 
    a3*b2^2 + a4*b2^2 + a5*b2^2 + a6*b2^2 - b1*b2^2 - b2^3 - a3*a4*b3 - 
    a3*a5*b3 - a4*a5*b3 - a3*a6*b3 - a4*a6*b3 - a5*a6*b3 + a3*b1*b3 + 
    a4*b1*b3 + a5*b1*b3 + a6*b1*b3 - b1^2*b3 + a3*b2*b3 + a4*b2*b3 + 
    a5*b2*b3 + a6*b2*b3 - b1*b2*b3 - b2^2*b3 + a3*b3^2 + a4*b3^2 + a5*b3^2 + 
    a6*b3^2 - b1*b3^2 - b2*b3^2 - b3^3 - a3*a4*b4 - a3*a5*b4 - a4*a5*b4 - 
    a3*a6*b4 - a4*a6*b4 - a5*a6*b4 + a3*b1*b4 + a4*b1*b4 + a5*b1*b4 + 
    a6*b1*b4 - b1^2*b4 + a3*b2*b4 + a4*b2*b4 + a5*b2*b4 + a6*b2*b4 - 
    b1*b2*b4 - b2^2*b4 + a3*b3*b4 + a4*b3*b4 + a5*b3*b4 + a6*b3*b4 - 
    b1*b3*b4 - b2*b3*b4 - b3^2*b4 + a3*b4^2 + a4*b4^2 + a5*b4^2 + a6*b4^2 - 
    b1*b4^2 - b2*b4^2 - b3*b4^2 - b4^3 - 
    (a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a5*b3 - 
      a6*b3 + b1*b3 + b2*b3 + b3^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4) + 
      a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4) - a5*b4 - a6*b4 + b1*b4 + b2*b4 + 
      b3*b4 + b4^2)*b5 + (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5^2 - 
    b5^3 + a1*(a4*a5 + a4*a6 + a5*a6 - a4*b1 - a5*b1 - a6*b1 + b1^2 - a4*b2 - 
      a5*b2 - a6*b2 + b1*b2 + b2^2 - a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + 
      b3^2 - a4*b4 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
      a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
      a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
      (a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2) + 
    a2*(a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a5*b3 - 
      a6*b3 + b1*b3 + b2*b3 + b3^2 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + 
      b4^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
      a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - a5*b5 - a6*b5 + b1*b5 + 
      b2*b5 + b3*b5 + b4*b5 + b5^2), HypExp`Private`PZ[6, 3, {1, 2}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)*
    (a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
     a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
     a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
     a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2), 
  HypExp`Private`PZ[6, 3, {2, 1}] -> (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - 
     b3 - b4 - b5)*(a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - 
     a4*b1 - a5*b1 - a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + 
     b2^2 - a3*b3 - a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - 
     a4*b4 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2), 
  HypExp`Private`PZ[6, 3, {1, 1, 1}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)^3, 
  HypExp`Private`PZ[6, 4, {4}] -> a3*a4*a5*a6 - a3*a4*a5*b1 - a3*a4*a6*b1 - 
    a3*a5*a6*b1 - a4*a5*a6*b1 + a3*a4*b1^2 + a3*a5*b1^2 + a4*a5*b1^2 + 
    a3*a6*b1^2 + a4*a6*b1^2 + a5*a6*b1^2 - a3*b1^3 - a4*b1^3 - a5*b1^3 - 
    a6*b1^3 + b1^4 - a3*a4*a5*b2 - a3*a4*a6*b2 - a3*a5*a6*b2 - a4*a5*a6*b2 + 
    a3*a4*b1*b2 + a3*a5*b1*b2 + a4*a5*b1*b2 + a3*a6*b1*b2 + a4*a6*b1*b2 + 
    a5*a6*b1*b2 - a3*b1^2*b2 - a4*b1^2*b2 - a5*b1^2*b2 - a6*b1^2*b2 + 
    b1^3*b2 + a3*a4*b2^2 + a3*a5*b2^2 + a4*a5*b2^2 + a3*a6*b2^2 + 
    a4*a6*b2^2 + a5*a6*b2^2 - a3*b1*b2^2 - a4*b1*b2^2 - a5*b1*b2^2 - 
    a6*b1*b2^2 + b1^2*b2^2 - a3*b2^3 - a4*b2^3 - a5*b2^3 - a6*b2^3 + 
    b1*b2^3 + b2^4 - a3*a4*a5*b3 - a3*a4*a6*b3 - a3*a5*a6*b3 - a4*a5*a6*b3 + 
    a3*a4*b1*b3 + a3*a5*b1*b3 + a4*a5*b1*b3 + a3*a6*b1*b3 + a4*a6*b1*b3 + 
    a5*a6*b1*b3 - a3*b1^2*b3 - a4*b1^2*b3 - a5*b1^2*b3 - a6*b1^2*b3 + 
    b1^3*b3 + a3*a4*b2*b3 + a3*a5*b2*b3 + a4*a5*b2*b3 + a3*a6*b2*b3 + 
    a4*a6*b2*b3 + a5*a6*b2*b3 - a3*b1*b2*b3 - a4*b1*b2*b3 - a5*b1*b2*b3 - 
    a6*b1*b2*b3 + b1^2*b2*b3 - a3*b2^2*b3 - a4*b2^2*b3 - a5*b2^2*b3 - 
    a6*b2^2*b3 + b1*b2^2*b3 + b2^3*b3 + a3*a4*b3^2 + a3*a5*b3^2 + 
    a4*a5*b3^2 + a3*a6*b3^2 + a4*a6*b3^2 + a5*a6*b3^2 - a3*b1*b3^2 - 
    a4*b1*b3^2 - a5*b1*b3^2 - a6*b1*b3^2 + b1^2*b3^2 - a3*b2*b3^2 - 
    a4*b2*b3^2 - a5*b2*b3^2 - a6*b2*b3^2 + b1*b2*b3^2 + b2^2*b3^2 - a3*b3^3 - 
    a4*b3^3 - a5*b3^3 - a6*b3^3 + b1*b3^3 + b2*b3^3 + b3^4 - a3*a4*a5*b4 - 
    a3*a4*a6*b4 - a3*a5*a6*b4 - a4*a5*a6*b4 + a3*a4*b1*b4 + a3*a5*b1*b4 + 
    a4*a5*b1*b4 + a3*a6*b1*b4 + a4*a6*b1*b4 + a5*a6*b1*b4 - a3*b1^2*b4 - 
    a4*b1^2*b4 - a5*b1^2*b4 - a6*b1^2*b4 + b1^3*b4 + a3*a4*b2*b4 + 
    a3*a5*b2*b4 + a4*a5*b2*b4 + a3*a6*b2*b4 + a4*a6*b2*b4 + a5*a6*b2*b4 - 
    a3*b1*b2*b4 - a4*b1*b2*b4 - a5*b1*b2*b4 - a6*b1*b2*b4 + b1^2*b2*b4 - 
    a3*b2^2*b4 - a4*b2^2*b4 - a5*b2^2*b4 - a6*b2^2*b4 + b1*b2^2*b4 + 
    b2^3*b4 + a3*a4*b3*b4 + a3*a5*b3*b4 + a4*a5*b3*b4 + a3*a6*b3*b4 + 
    a4*a6*b3*b4 + a5*a6*b3*b4 - a3*b1*b3*b4 - a4*b1*b3*b4 - a5*b1*b3*b4 - 
    a6*b1*b3*b4 + b1^2*b3*b4 - a3*b2*b3*b4 - a4*b2*b3*b4 - a5*b2*b3*b4 - 
    a6*b2*b3*b4 + b1*b2*b3*b4 + b2^2*b3*b4 - a3*b3^2*b4 - a4*b3^2*b4 - 
    a5*b3^2*b4 - a6*b3^2*b4 + b1*b3^2*b4 + b2*b3^2*b4 + b3^3*b4 + 
    a3*a4*b4^2 + a3*a5*b4^2 + a4*a5*b4^2 + a3*a6*b4^2 + a4*a6*b4^2 + 
    a5*a6*b4^2 - a3*b1*b4^2 - a4*b1*b4^2 - a5*b1*b4^2 - a6*b1*b4^2 + 
    b1^2*b4^2 - a3*b2*b4^2 - a4*b2*b4^2 - a5*b2*b4^2 - a6*b2*b4^2 + 
    b1*b2*b4^2 + b2^2*b4^2 - a3*b3*b4^2 - a4*b3*b4^2 - a5*b3*b4^2 - 
    a6*b3*b4^2 + b1*b3*b4^2 + b2*b3*b4^2 + b3^2*b4^2 - a3*b4^3 - a4*b4^3 - 
    a5*b4^3 - a6*b4^3 + b1*b4^3 + b2*b4^3 + b3*b4^3 + b4^4 + 
    (a5*a6*b1 - a5*b1^2 - a6*b1^2 + b1^3 + a5*a6*b2 - a5*b1*b2 - a6*b1*b2 + 
      b1^2*b2 - a5*b2^2 - a6*b2^2 + b1*b2^2 + b2^3 + a5*a6*b3 - a5*b1*b3 - 
      a6*b1*b3 + b1^2*b3 - a5*b2*b3 - a6*b2*b3 + b1*b2*b3 + b2^2*b3 - 
      a5*b3^2 - a6*b3^2 + b1*b3^2 + b2*b3^2 + b3^3 + 
      (b1^2 + b1*b2 + b2^2 + a5*(a6 - b1 - b2 - b3) + (b1 + b2)*b3 + b3^2 - 
        a6*(b1 + b2 + b3))*b4 - (a5 + a6 - b1 - b2 - b3)*b4^2 + b4^3 - 
      a3*(-(a6*b1) + b1^2 - a6*b2 + b1*b2 + b2^2 - a6*b3 + b1*b3 + b2*b3 + 
        b3^2 + a5*(a6 - b1 - b2 - b3 - b4) + a4*(a5 + a6 - b1 - b2 - b3 - 
          b4) - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2) - 
      a4*(b1^2 + b1*b2 + b2^2 + b1*b3 + b2*b3 + b3^2 + 
        a5*(a6 - b1 - b2 - b3 - b4) + (b1 + b2 + b3)*b4 + b4^2 - 
        a6*(b1 + b2 + b3 + b4)))*b5 + (a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - 
      a6*b2 + b1*b2 + b2^2 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 + 
      a4*(a5 + a6 - b1 - b2 - b3 - b4) + a3*(a4 + a5 + a6 - b1 - b2 - b3 - 
        b4) - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2)*b5^2 - 
    (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5^3 + b5^4 + 
    a1*(a4*a5*a6 - a4*a5*b1 - a4*a6*b1 - a5*a6*b1 + a4*b1^2 + a5*b1^2 + 
      a6*b1^2 - b1^3 - a4*a5*b2 - a4*a6*b2 - a5*a6*b2 + a4*b1*b2 + a5*b1*b2 + 
      a6*b1*b2 - b1^2*b2 + a4*b2^2 + a5*b2^2 + a6*b2^2 - b1*b2^2 - b2^3 - 
      a4*a5*b3 - a4*a6*b3 - a5*a6*b3 + a4*b1*b3 + a5*b1*b3 + a6*b1*b3 - 
      b1^2*b3 + a4*b2*b3 + a5*b2*b3 + a6*b2*b3 - b1*b2*b3 - b2^2*b3 + 
      a4*b3^2 + a5*b3^2 + a6*b3^2 - b1*b3^2 - b2*b3^2 - b3^3 - a4*a5*b4 - 
      a4*a6*b4 - a5*a6*b4 + a4*b1*b4 + a5*b1*b4 + a6*b1*b4 - b1^2*b4 + 
      a4*b2*b4 + a5*b2*b4 + a6*b2*b4 - b1*b2*b4 - b2^2*b4 + a4*b3*b4 + 
      a5*b3*b4 + a6*b3*b4 - b1*b3*b4 - b2*b3*b4 - b3^2*b4 + a4*b4^2 + 
      a5*b4^2 + a6*b4^2 - b1*b4^2 - b2*b4^2 - b3*b4^2 - b4^3 - 
      (-(a6*b1) + b1^2 - a6*b2 + b1*b2 + b2^2 - a6*b3 + b1*b3 + b2*b3 + 
        b3^2 + a5*(a6 - b1 - b2 - b3 - b4) + a4*(a5 + a6 - b1 - b2 - b3 - 
          b4) - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2)*b5 + 
      (a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5^2 - b5^3 + 
      a3*(-(a6*b1) + b1^2 - a6*b2 + b1*b2 + b2^2 - a6*b3 + b1*b3 + b2*b3 + 
        b3^2 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
        a5*(a6 - b1 - b2 - b3 - b4 - b5) + a4*(a5 + a6 - b1 - b2 - b3 - b4 - 
          b5) - a6*b5 + b1*b5 + b2*b5 + b3*b5 + b4*b5 + b5^2) + 
      a2*(a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - 
        a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a5*b4 - a6*b4 + b1*b4 + 
        b2*b4 + b3*b4 + b4^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
        a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - a5*b5 - a6*b5 + b1*b5 + 
        b2*b5 + b3*b5 + b4*b5 + b5^2)) + 
    a2*(-(a5*a6*b1) + a5*b1^2 + a6*b1^2 - b1^3 - a5*a6*b2 + a5*b1*b2 + 
      a6*b1*b2 - b1^2*b2 + a5*b2^2 + a6*b2^2 - b1*b2^2 - b2^3 - a5*a6*b3 + 
      a5*b1*b3 + a6*b1*b3 - b1^2*b3 + a5*b2*b3 + a6*b2*b3 - b1*b2*b3 - 
      b2^2*b3 + a5*b3^2 + a6*b3^2 - b1*b3^2 - b2*b3^2 - b3^3 - a5*a6*b4 + 
      a5*b1*b4 + a6*b1*b4 - b1^2*b4 + a5*b2*b4 + a6*b2*b4 - b1*b2*b4 - 
      b2^2*b4 + a5*b3*b4 + a6*b3*b4 - b1*b3*b4 - b2*b3*b4 - b3^2*b4 + 
      a5*b4^2 + a6*b4^2 - b1*b4^2 - b2*b4^2 - b3*b4^2 - b4^3 - 
      (b1^2 + b1*b2 + b2^2 + b1*b3 + b2*b3 + b3^2 + 
        a5*(a6 - b1 - b2 - b3 - b4) + (b1 + b2 + b3)*b4 + b4^2 - 
        a6*(b1 + b2 + b3 + b4))*b5 + (a5 + a6 - b1 - b2 - b3 - b4)*b5^2 - 
      b5^3 + a3*(-(a6*b1) + b1^2 - a6*b2 + b1*b2 + b2^2 - a6*b3 + b1*b3 + 
        b2*b3 + b3^2 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
        a5*(a6 - b1 - b2 - b3 - b4 - b5) + a4*(a5 + a6 - b1 - b2 - b3 - b4 - 
          b5) - a6*b5 + b1*b5 + b2*b5 + b3*b5 + b4*b5 + b5^2) + 
      a4*(b1^2 + b1*b2 + b2^2 + b1*b3 + b2*b3 + b3^2 + b1*b4 + b2*b4 + 
        b3*b4 + b4^2 + a5*(a6 - b1 - b2 - b3 - b4 - b5) + 
        (b1 + b2 + b3 + b4)*b5 + b5^2 - a6*(b1 + b2 + b3 + b4 + b5))), 
  HypExp`Private`PZ[6, 4, {1, 3}] -> (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - 
     b3 - b4 - b5)*(a3*a4*a5 + a3*a4*a6 + a3*a5*a6 + a4*a5*a6 - a3*a4*b1 - 
     a3*a5*b1 - a4*a5*b1 - a3*a6*b1 - a4*a6*b1 - a5*a6*b1 + a3*b1^2 + 
     a4*b1^2 + a5*b1^2 + a6*b1^2 - b1^3 - a3*a4*b2 - a3*a5*b2 - a4*a5*b2 - 
     a3*a6*b2 - a4*a6*b2 - a5*a6*b2 + a3*b1*b2 + a4*b1*b2 + a5*b1*b2 + 
     a6*b1*b2 - b1^2*b2 + a3*b2^2 + a4*b2^2 + a5*b2^2 + a6*b2^2 - b1*b2^2 - 
     b2^3 - a3*a4*b3 - a3*a5*b3 - a4*a5*b3 - a3*a6*b3 - a4*a6*b3 - a5*a6*b3 + 
     a3*b1*b3 + a4*b1*b3 + a5*b1*b3 + a6*b1*b3 - b1^2*b3 + a3*b2*b3 + 
     a4*b2*b3 + a5*b2*b3 + a6*b2*b3 - b1*b2*b3 - b2^2*b3 + a3*b3^2 + 
     a4*b3^2 + a5*b3^2 + a6*b3^2 - b1*b3^2 - b2*b3^2 - b3^3 - a3*a4*b4 - 
     a3*a5*b4 - a4*a5*b4 - a3*a6*b4 - a4*a6*b4 - a5*a6*b4 + a3*b1*b4 + 
     a4*b1*b4 + a5*b1*b4 + a6*b1*b4 - b1^2*b4 + a3*b2*b4 + a4*b2*b4 + 
     a5*b2*b4 + a6*b2*b4 - b1*b2*b4 - b2^2*b4 + a3*b3*b4 + a4*b3*b4 + 
     a5*b3*b4 + a6*b3*b4 - b1*b3*b4 - b2*b3*b4 - b3^2*b4 + a3*b4^2 + 
     a4*b4^2 + a5*b4^2 + a6*b4^2 - b1*b4^2 - b2*b4^2 - b3*b4^2 - b4^3 - 
     (a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a5*b3 - 
       a6*b3 + b1*b3 + b2*b3 + b3^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4) + 
       a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4) - a5*b4 - a6*b4 + b1*b4 + 
       b2*b4 + b3*b4 + b4^2)*b5 + (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*
      b5^2 - b5^3 + a1*(a4*a5 + a4*a6 + a5*a6 - a4*b1 - a5*b1 - a6*b1 + 
       b1^2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a4*b3 - a5*b3 - a6*b3 + 
       b1*b3 + b2*b3 + b3^2 - a4*b4 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + 
       b4^2 + a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
       a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
       (a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2) + 
     a2*(a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - 
       a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + 
       b3*b4 + b4^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
       a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - a5*b5 - a6*b5 + b1*b5 + 
       b2*b5 + b3*b5 + b4*b5 + b5^2)), HypExp`Private`PZ[6, 4, {2, 2}] -> 
   (a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
     a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
     a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
     a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2)^2, 
  HypExp`Private`PZ[6, 4, {3, 1}] -> (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - 
     b3 - b4 - b5)*(a3*a4*a5 + a3*a4*a6 + a3*a5*a6 + a4*a5*a6 - a3*a4*b1 - 
     a3*a5*b1 - a4*a5*b1 - a3*a6*b1 - a4*a6*b1 - a5*a6*b1 + a3*b1^2 + 
     a4*b1^2 + a5*b1^2 + a6*b1^2 - b1^3 - a3*a4*b2 - a3*a5*b2 - a4*a5*b2 - 
     a3*a6*b2 - a4*a6*b2 - a5*a6*b2 + a3*b1*b2 + a4*b1*b2 + a5*b1*b2 + 
     a6*b1*b2 - b1^2*b2 + a3*b2^2 + a4*b2^2 + a5*b2^2 + a6*b2^2 - b1*b2^2 - 
     b2^3 - a3*a4*b3 - a3*a5*b3 - a4*a5*b3 - a3*a6*b3 - a4*a6*b3 - a5*a6*b3 + 
     a3*b1*b3 + a4*b1*b3 + a5*b1*b3 + a6*b1*b3 - b1^2*b3 + a3*b2*b3 + 
     a4*b2*b3 + a5*b2*b3 + a6*b2*b3 - b1*b2*b3 - b2^2*b3 + a3*b3^2 + 
     a4*b3^2 + a5*b3^2 + a6*b3^2 - b1*b3^2 - b2*b3^2 - b3^3 - a3*a4*b4 - 
     a3*a5*b4 - a4*a5*b4 - a3*a6*b4 - a4*a6*b4 - a5*a6*b4 + a3*b1*b4 + 
     a4*b1*b4 + a5*b1*b4 + a6*b1*b4 - b1^2*b4 + a3*b2*b4 + a4*b2*b4 + 
     a5*b2*b4 + a6*b2*b4 - b1*b2*b4 - b2^2*b4 + a3*b3*b4 + a4*b3*b4 + 
     a5*b3*b4 + a6*b3*b4 - b1*b3*b4 - b2*b3*b4 - b3^2*b4 + a3*b4^2 + 
     a4*b4^2 + a5*b4^2 + a6*b4^2 - b1*b4^2 - b2*b4^2 - b3*b4^2 - b4^3 - 
     (a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a5*b3 - 
       a6*b3 + b1*b3 + b2*b3 + b3^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4) + 
       a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4) - a5*b4 - a6*b4 + b1*b4 + 
       b2*b4 + b3*b4 + b4^2)*b5 + (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*
      b5^2 - b5^3 + a1*(a4*a5 + a4*a6 + a5*a6 - a4*b1 - a5*b1 - a6*b1 + 
       b1^2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a4*b3 - a5*b3 - a6*b3 + 
       b1*b3 + b2*b3 + b3^2 - a4*b4 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + b3*b4 + 
       b4^2 + a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
       a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
       (a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2) + 
     a2*(a5*a6 - a5*b1 - a6*b1 + b1^2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - 
       a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a5*b4 - a6*b4 + b1*b4 + b2*b4 + 
       b3*b4 + b4^2 + a4*(a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
       a3*(a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - a5*b5 - a6*b5 + b1*b5 + 
       b2*b5 + b3*b5 + b4*b5 + b5^2)), HypExp`Private`PZ[6, 4, {1, 1, 2}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)^2*
    (a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
     a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
     a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
     a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2), 
  HypExp`Private`PZ[6, 4, {1, 2, 1}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)^2*
    (a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
     a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
     a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
     a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2), 
  HypExp`Private`PZ[6, 4, {2, 1, 1}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)^2*
    (a3*a4 + a3*a5 + a4*a5 + a3*a6 + a4*a6 + a5*a6 - a3*b1 - a4*b1 - a5*b1 - 
     a6*b1 + b1^2 - a3*b2 - a4*b2 - a5*b2 - a6*b2 + b1*b2 + b2^2 - a3*b3 - 
     a4*b3 - a5*b3 - a6*b3 + b1*b3 + b2*b3 + b3^2 - a3*b4 - a4*b4 - a5*b4 - 
     a6*b4 + b1*b4 + b2*b4 + b3*b4 + b4^2 + 
     a2*(a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) + 
     a1*(a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5) - 
     (a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4)*b5 + b5^2), 
  HypExp`Private`PZ[6, 4, {1, 1, 1, 1}] -> 
   (a1 + a2 + a3 + a4 + a5 + a6 - b1 - b2 - b3 - b4 - b5)^4}]
