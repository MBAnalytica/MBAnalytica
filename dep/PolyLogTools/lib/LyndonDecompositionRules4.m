LyndonDecompositionRules4 = {word[a1, a1] -> word[a1]^2/2, 
    word[a2, a1] -> word[a1]*word[a2] - word[a1, a2], 
    word[a2, a2] -> word[a2]^2/2, word[a3, a1] -> word[a1]*word[a3] - 
      word[a1, a3], word[a3, a2] -> word[a2]*word[a3] - word[a2, a3], 
    word[a3, a3] -> word[a3]^2/2, word[a4, a1] -> word[a1]*word[a4] - 
      word[a1, a4], word[a4, a2] -> word[a2]*word[a4] - word[a2, a4], 
    word[a4, a3] -> word[a3]*word[a4] - word[a3, a4], 
    word[a4, a4] -> word[a4]^2/2, word[a1, a1, a1] -> word[a1]^3/6, 
    word[a1, a2, a1] -> word[a1]*word[a1, a2] - 2*word[a1, a1, a2], 
    word[a1, a3, a1] -> word[a1]*word[a1, a3] - 2*word[a1, a1, a3], 
    word[a1, a4, a1] -> word[a1]*word[a1, a4] - 2*word[a1, a1, a4], 
    word[a2, a1, a1] -> (word[a1]^2*word[a2])/2 - word[a1]*word[a1, a2] + 
      word[a1, a1, a2], word[a2, a1, a2] -> word[a2]*word[a1, a2] - 
      2*word[a1, a2, a2], word[a2, a1, a3] -> word[a2]*word[a1, a3] - 
      word[a1, a2, a3] - word[a1, a3, a2], word[a2, a1, a4] -> 
     word[a2]*word[a1, a4] - word[a1, a2, a4] - word[a1, a4, a2], 
    word[a2, a2, a1] -> (word[a1]*word[a2]^2)/2 - word[a2]*word[a1, a2] + 
      word[a1, a2, a2], word[a2, a2, a2] -> word[a2]^3/6, 
    word[a2, a3, a1] -> -(word[a2]*word[a1, a3]) + word[a1]*word[a2, a3] + 
      word[a1, a3, a2], word[a2, a3, a2] -> word[a2]*word[a2, a3] - 
      2*word[a2, a2, a3], word[a2, a4, a1] -> -(word[a2]*word[a1, a4]) + 
      word[a1]*word[a2, a4] + word[a1, a4, a2], word[a2, a4, a2] -> 
     word[a2]*word[a2, a4] - 2*word[a2, a2, a4], word[a3, a1, a1] -> 
     (word[a1]^2*word[a3])/2 - word[a1]*word[a1, a3] + word[a1, a1, a3], 
    word[a3, a1, a2] -> word[a3]*word[a1, a2] - word[a1, a2, a3] - 
      word[a1, a3, a2], word[a3, a1, a3] -> word[a3]*word[a1, a3] - 
      2*word[a1, a3, a3], word[a3, a1, a4] -> word[a3]*word[a1, a4] - 
      word[a1, a3, a4] - word[a1, a4, a3], word[a3, a2, a1] -> 
     word[a1]*word[a2]*word[a3] - word[a3]*word[a1, a2] - 
      word[a1]*word[a2, a3] + word[a1, a2, a3], word[a3, a2, a2] -> 
     (word[a2]^2*word[a3])/2 - word[a2]*word[a2, a3] + word[a2, a2, a3], 
    word[a3, a2, a3] -> word[a3]*word[a2, a3] - 2*word[a2, a3, a3], 
    word[a3, a2, a4] -> word[a3]*word[a2, a4] - word[a2, a3, a4] - 
      word[a2, a4, a3], word[a3, a3, a1] -> (word[a1]*word[a3]^2)/2 - 
      word[a3]*word[a1, a3] + word[a1, a3, a3], word[a3, a3, a2] -> 
     (word[a2]*word[a3]^2)/2 - word[a3]*word[a2, a3] + word[a2, a3, a3], 
    word[a3, a3, a3] -> word[a3]^3/6, word[a3, a4, a1] -> 
     -(word[a3]*word[a1, a4]) + word[a1]*word[a3, a4] + word[a1, a4, a3], 
    word[a3, a4, a2] -> -(word[a3]*word[a2, a4]) + word[a2]*word[a3, a4] + 
      word[a2, a4, a3], word[a3, a4, a3] -> word[a3]*word[a3, a4] - 
      2*word[a3, a3, a4], word[a4, a1, a1] -> (word[a1]^2*word[a4])/2 - 
      word[a1]*word[a1, a4] + word[a1, a1, a4], word[a4, a1, a2] -> 
     word[a4]*word[a1, a2] - word[a1, a2, a4] - word[a1, a4, a2], 
    word[a4, a1, a3] -> word[a4]*word[a1, a3] - word[a1, a3, a4] - 
      word[a1, a4, a3], word[a4, a1, a4] -> word[a4]*word[a1, a4] - 
      2*word[a1, a4, a4], word[a4, a2, a1] -> word[a1]*word[a2]*word[a4] - 
      word[a4]*word[a1, a2] - word[a1]*word[a2, a4] + word[a1, a2, a4], 
    word[a4, a2, a2] -> (word[a2]^2*word[a4])/2 - word[a2]*word[a2, a4] + 
      word[a2, a2, a4], word[a4, a2, a3] -> word[a4]*word[a2, a3] - 
      word[a2, a3, a4] - word[a2, a4, a3], word[a4, a2, a4] -> 
     word[a4]*word[a2, a4] - 2*word[a2, a4, a4], word[a4, a3, a1] -> 
     word[a1]*word[a3]*word[a4] - word[a4]*word[a1, a3] - 
      word[a1]*word[a3, a4] + word[a1, a3, a4], word[a4, a3, a2] -> 
     word[a2]*word[a3]*word[a4] - word[a4]*word[a2, a3] - 
      word[a2]*word[a3, a4] + word[a2, a3, a4], word[a4, a3, a3] -> 
     (word[a3]^2*word[a4])/2 - word[a3]*word[a3, a4] + word[a3, a3, a4], 
    word[a4, a3, a4] -> word[a4]*word[a3, a4] - 2*word[a3, a4, a4], 
    word[a4, a4, a1] -> (word[a1]*word[a4]^2)/2 - word[a4]*word[a1, a4] + 
      word[a1, a4, a4], word[a4, a4, a2] -> (word[a2]*word[a4]^2)/2 - 
      word[a4]*word[a2, a4] + word[a2, a4, a4], word[a4, a4, a3] -> 
     (word[a3]*word[a4]^2)/2 - word[a4]*word[a3, a4] + word[a3, a4, a4], 
    word[a4, a4, a4] -> word[a4]^3/6, word[a1, a1, a1, a1] -> word[a1]^4/24, 
    word[a1, a1, a2, a1] -> word[a1]*word[a1, a1, a2] - 
      3*word[a1, a1, a1, a2], word[a1, a1, a3, a1] -> 
     word[a1]*word[a1, a1, a3] - 3*word[a1, a1, a1, a3], 
    word[a1, a1, a4, a1] -> word[a1]*word[a1, a1, a4] - 
      3*word[a1, a1, a1, a4], word[a1, a2, a1, a1] -> 
     (word[a1]^2*word[a1, a2])/2 - 2*word[a1]*word[a1, a1, a2] + 
      3*word[a1, a1, a1, a2], word[a1, a2, a1, a2] -> 
     (word[a1, a2]^2 - 4*word[a1, a1, a2, a2])/2, word[a1, a2, a2, a1] -> 
     -word[a1, a2]^2/2 + word[a1]*word[a1, a2, a2], 
    word[a1, a2, a3, a1] -> word[a1]*word[a1, a2, a3] - 
      2*word[a1, a1, a2, a3] - word[a1, a2, a1, a3], 
    word[a1, a2, a4, a1] -> word[a1]*word[a1, a2, a4] - 
      2*word[a1, a1, a2, a4] - word[a1, a2, a1, a4], 
    word[a1, a3, a1, a1] -> (word[a1]^2*word[a1, a3])/2 - 
      2*word[a1]*word[a1, a1, a3] + 3*word[a1, a1, a1, a3], 
    word[a1, a3, a1, a2] -> word[a1, a2]*word[a1, a3] - 
      2*word[a1, a1, a2, a3] - 2*word[a1, a1, a3, a2] - word[a1, a2, a1, a3], 
    word[a1, a3, a1, a3] -> (word[a1, a3]^2 - 4*word[a1, a1, a3, a3])/2, 
    word[a1, a3, a2, a1] -> -(word[a1, a2]*word[a1, a3]) + 
      word[a1]*word[a1, a3, a2] + 2*word[a1, a1, a2, a3] + 
      word[a1, a2, a1, a3], word[a1, a3, a3, a1] -> 
     -word[a1, a3]^2/2 + word[a1]*word[a1, a3, a3], 
    word[a1, a3, a4, a1] -> word[a1]*word[a1, a3, a4] - 
      2*word[a1, a1, a3, a4] - word[a1, a3, a1, a4], 
    word[a1, a4, a1, a1] -> (word[a1]^2*word[a1, a4])/2 - 
      2*word[a1]*word[a1, a1, a4] + 3*word[a1, a1, a1, a4], 
    word[a1, a4, a1, a2] -> word[a1, a2]*word[a1, a4] - 
      2*word[a1, a1, a2, a4] - 2*word[a1, a1, a4, a2] - word[a1, a2, a1, a4], 
    word[a1, a4, a1, a3] -> word[a1, a3]*word[a1, a4] - 
      2*word[a1, a1, a3, a4] - 2*word[a1, a1, a4, a3] - word[a1, a3, a1, a4], 
    word[a1, a4, a1, a4] -> (word[a1, a4]^2 - 4*word[a1, a1, a4, a4])/2, 
    word[a1, a4, a2, a1] -> -(word[a1, a2]*word[a1, a4]) + 
      word[a1]*word[a1, a4, a2] + 2*word[a1, a1, a2, a4] + 
      word[a1, a2, a1, a4], word[a1, a4, a3, a1] -> 
     -(word[a1, a3]*word[a1, a4]) + word[a1]*word[a1, a4, a3] + 
      2*word[a1, a1, a3, a4] + word[a1, a3, a1, a4], 
    word[a1, a4, a4, a1] -> (-word[a1, a4]^2 + 2*word[a1]*word[a1, a4, a4])/
      2, word[a2, a1, a1, a1] -> (word[a1]^3*word[a2])/6 - 
      (word[a1]^2*word[a1, a2])/2 + word[a1]*word[a1, a1, a2] - 
      word[a1, a1, a1, a2], word[a2, a1, a1, a2] -> 
     (-word[a1, a2]^2 + 2*word[a2]*word[a1, a1, a2])/2, 
    word[a2, a1, a1, a3] -> word[a2]*word[a1, a1, a3] - 
      word[a1, a1, a2, a3] - word[a1, a1, a3, a2] - word[a1, a2, a1, a3], 
    word[a2, a1, a1, a4] -> word[a2]*word[a1, a1, a4] - 
      word[a1, a1, a2, a4] - word[a1, a1, a4, a2] - word[a1, a2, a1, a4], 
    word[a2, a1, a2, a1] -> word[a1]*word[a2]*word[a1, a2] + 
      word[a1, a2]^2/2 - 2*word[a2]*word[a1, a1, a2] - 
      2*word[a1]*word[a1, a2, a2] + 2*word[a1, a1, a2, a2], 
    word[a2, a1, a2, a2] -> word[a2]*word[a1, a2, a2] - 
      3*word[a1, a2, a2, a2], word[a2, a1, a2, a3] -> 
     word[a2]*word[a1, a2, a3] - 2*word[a1, a2, a2, a3] - 
      word[a1, a2, a3, a2], word[a2, a1, a2, a4] -> 
     word[a2]*word[a1, a2, a4] - 2*word[a1, a2, a2, a4] - 
      word[a1, a2, a4, a2], word[a2, a1, a3, a1] -> 
     word[a1]*word[a2]*word[a1, a3] - 2*word[a2]*word[a1, a1, a3] - 
      word[a1]*word[a1, a2, a3] - word[a1]*word[a1, a3, a2] + 
      2*word[a1, a1, a2, a3] + 2*word[a1, a1, a3, a2] + word[a1, a2, a1, a3], 
    word[a2, a1, a3, a2] -> word[a2]*word[a1, a3, a2] - 
      word[a1, a2, a3, a2] - 2*word[a1, a3, a2, a2], 
    word[a2, a1, a3, a3] -> word[a2]*word[a1, a3, a3] - 
      word[a1, a2, a3, a3] - word[a1, a3, a2, a3] - word[a1, a3, a3, a2], 
    word[a2, a1, a3, a4] -> word[a2]*word[a1, a3, a4] - 
      word[a1, a2, a3, a4] - word[a1, a3, a2, a4] - word[a1, a3, a4, a2], 
    word[a2, a1, a4, a1] -> word[a1]*word[a2]*word[a1, a4] - 
      2*word[a2]*word[a1, a1, a4] - word[a1]*word[a1, a2, a4] - 
      word[a1]*word[a1, a4, a2] + 2*word[a1, a1, a2, a4] + 
      2*word[a1, a1, a4, a2] + word[a1, a2, a1, a4], 
    word[a2, a1, a4, a2] -> word[a2]*word[a1, a4, a2] - 
      word[a1, a2, a4, a2] - 2*word[a1, a4, a2, a2], 
    word[a2, a1, a4, a3] -> word[a2]*word[a1, a4, a3] - 
      word[a1, a2, a4, a3] - word[a1, a4, a2, a3] - word[a1, a4, a3, a2], 
    word[a2, a1, a4, a4] -> word[a2]*word[a1, a4, a4] - 
      word[a1, a2, a4, a4] - word[a1, a4, a2, a4] - word[a1, a4, a4, a2], 
    word[a2, a2, a1, a1] -> (word[a1]^2*word[a2]^2)/4 - 
      word[a1]*word[a2]*word[a1, a2] + word[a2]*word[a1, a1, a2] + 
      word[a1]*word[a1, a2, a2] - word[a1, a1, a2, a2], 
    word[a2, a2, a1, a2] -> (word[a2]^2*word[a1, a2])/2 - 
      2*word[a2]*word[a1, a2, a2] + 3*word[a1, a2, a2, a2], 
    word[a2, a2, a1, a3] -> (word[a2]^2*word[a1, a3])/2 - 
      word[a2]*word[a1, a2, a3] - word[a2]*word[a1, a3, a2] + 
      word[a1, a2, a2, a3] + word[a1, a2, a3, a2] + word[a1, a3, a2, a2], 
    word[a2, a2, a1, a4] -> (word[a2]^2*word[a1, a4])/2 - 
      word[a2]*word[a1, a2, a4] - word[a2]*word[a1, a4, a2] + 
      word[a1, a2, a2, a4] + word[a1, a2, a4, a2] + word[a1, a4, a2, a2], 
    word[a2, a2, a2, a1] -> (word[a1]*word[a2]^3)/6 - 
      (word[a2]^2*word[a1, a2])/2 + word[a2]*word[a1, a2, a2] - 
      word[a1, a2, a2, a2], word[a2, a2, a2, a2] -> word[a2]^4/24, 
    word[a2, a2, a3, a1] -> (-(word[a2]^2*word[a1, a3]) + 
       2*word[a2]*word[a1, a3, a2] + 2*word[a1]*word[a2, a2, a3] - 
       2*word[a1, a3, a2, a2])/2, word[a2, a2, a3, a2] -> 
     word[a2]*word[a2, a2, a3] - 3*word[a2, a2, a2, a3], 
    word[a2, a2, a4, a1] -> -(word[a2]^2*word[a1, a4])/2 + 
      word[a2]*word[a1, a4, a2] + word[a1]*word[a2, a2, a4] - 
      word[a1, a4, a2, a2], word[a2, a2, a4, a2] -> 
     word[a2]*word[a2, a2, a4] - 3*word[a2, a2, a2, a4], 
    word[a2, a3, a1, a1] -> -(word[a1]*word[a2]*word[a1, a3]) + 
      (word[a1]^2*word[a2, a3])/2 + word[a2]*word[a1, a1, a3] + 
      word[a1]*word[a1, a3, a2] - word[a1, a1, a3, a2], 
    word[a2, a3, a1, a2] -> word[a1, a2]*word[a2, a3] - 
      word[a2]*word[a1, a2, a3] - word[a2]*word[a1, a3, a2] + 
      word[a1, a2, a3, a2] + 2*word[a1, a3, a2, a2], 
    word[a2, a3, a1, a3] -> word[a1, a3]*word[a2, a3] - 
      2*word[a2]*word[a1, a3, a3] + word[a1, a3, a2, a3] + 
      2*word[a1, a3, a3, a2], word[a2, a3, a1, a4] -> 
     word[a1, a4]*word[a2, a3] - word[a2]*word[a1, a3, a4] - 
      word[a2]*word[a1, a4, a3] + word[a1, a3, a2, a4] + 
      word[a1, a3, a4, a2] + word[a1, a4, a3, a2], 
    word[a2, a3, a2, a1] -> word[a1]*word[a2]*word[a2, a3] - 
      word[a1, a2]*word[a2, a3] + word[a2]*word[a1, a2, a3] - 
      2*word[a1]*word[a2, a2, a3] - word[a1, a2, a3, a2], 
    word[a2, a3, a2, a2] -> (word[a2]^2*word[a2, a3])/2 - 
      2*word[a2]*word[a2, a2, a3] + 3*word[a2, a2, a2, a3], 
    word[a2, a3, a2, a3] -> (word[a2, a3]^2 - 4*word[a2, a2, a3, a3])/2, 
    word[a2, a3, a3, a1] -> -(word[a1, a3]*word[a2, a3]) + 
      word[a2]*word[a1, a3, a3] + word[a1]*word[a2, a3, a3] - 
      word[a1, a3, a3, a2], word[a2, a3, a3, a2] -> 
     (-word[a2, a3]^2 + 2*word[a2]*word[a2, a3, a3])/2, 
    word[a2, a3, a4, a1] -> -(word[a1, a4]*word[a2, a3]) + 
      word[a2]*word[a1, a4, a3] + word[a1]*word[a2, a3, a4] - 
      word[a1, a4, a3, a2], word[a2, a3, a4, a2] -> 
     word[a2]*word[a2, a3, a4] - 2*word[a2, a2, a3, a4] - 
      word[a2, a3, a2, a4], word[a2, a4, a1, a1] -> 
     -(word[a1]*word[a2]*word[a1, a4]) + (word[a1]^2*word[a2, a4])/2 + 
      word[a2]*word[a1, a1, a4] + word[a1]*word[a1, a4, a2] - 
      word[a1, a1, a4, a2], word[a2, a4, a1, a2] -> 
     word[a1, a2]*word[a2, a4] - word[a2]*word[a1, a2, a4] - 
      word[a2]*word[a1, a4, a2] + word[a1, a2, a4, a2] + 
      2*word[a1, a4, a2, a2], word[a2, a4, a1, a3] -> 
     word[a1, a3]*word[a2, a4] - word[a2]*word[a1, a3, a4] - 
      word[a2]*word[a1, a4, a3] + word[a1, a3, a4, a2] + 
      word[a1, a4, a2, a3] + word[a1, a4, a3, a2], 
    word[a2, a4, a1, a4] -> word[a1, a4]*word[a2, a4] - 
      2*word[a2]*word[a1, a4, a4] + word[a1, a4, a2, a4] + 
      2*word[a1, a4, a4, a2], word[a2, a4, a2, a1] -> 
     word[a1]*word[a2]*word[a2, a4] - word[a1, a2]*word[a2, a4] + 
      word[a2]*word[a1, a2, a4] - 2*word[a1]*word[a2, a2, a4] - 
      word[a1, a2, a4, a2], word[a2, a4, a2, a2] -> 
     (word[a2]^2*word[a2, a4])/2 - 2*word[a2]*word[a2, a2, a4] + 
      3*word[a2, a2, a2, a4], word[a2, a4, a2, a3] -> 
     word[a2, a3]*word[a2, a4] - 2*word[a2, a2, a3, a4] - 
      2*word[a2, a2, a4, a3] - word[a2, a3, a2, a4], 
    word[a2, a4, a2, a4] -> (word[a2, a4]^2 - 4*word[a2, a2, a4, a4])/2, 
    word[a2, a4, a3, a1] -> -(word[a1, a3]*word[a2, a4]) + 
      word[a2]*word[a1, a3, a4] + word[a1]*word[a2, a4, a3] - 
      word[a1, a3, a4, a2], word[a2, a4, a3, a2] -> 
     -(word[a2, a3]*word[a2, a4]) + word[a2]*word[a2, a4, a3] + 
      2*word[a2, a2, a3, a4] + word[a2, a3, a2, a4], 
    word[a2, a4, a4, a1] -> -(word[a1, a4]*word[a2, a4]) + 
      word[a2]*word[a1, a4, a4] + word[a1]*word[a2, a4, a4] - 
      word[a1, a4, a4, a2], word[a2, a4, a4, a2] -> 
     (-word[a2, a4]^2 + 2*word[a2]*word[a2, a4, a4])/2, 
    word[a3, a1, a1, a1] -> (word[a1]^3*word[a3])/6 - 
      (word[a1]^2*word[a1, a3])/2 + word[a1]*word[a1, a1, a3] - 
      word[a1, a1, a1, a3], word[a3, a1, a1, a2] -> 
     -(word[a1, a2]*word[a1, a3]) + word[a3]*word[a1, a1, a2] + 
      word[a1, a1, a2, a3] + word[a1, a1, a3, a2] + word[a1, a2, a1, a3], 
    word[a3, a1, a1, a3] -> (-word[a1, a3]^2 + 2*word[a3]*word[a1, a1, a3])/
      2, word[a3, a1, a1, a4] -> word[a3]*word[a1, a1, a4] - 
      word[a1, a1, a3, a4] - word[a1, a1, a4, a3] - word[a1, a3, a1, a4], 
    word[a3, a1, a2, a1] -> word[a1]*word[a3]*word[a1, a2] + 
      word[a1, a2]*word[a1, a3] - 2*word[a3]*word[a1, a1, a2] - 
      word[a1]*word[a1, a2, a3] - word[a1]*word[a1, a3, a2] - 
      word[a1, a2, a1, a3], word[a3, a1, a2, a2] -> 
     word[a3]*word[a1, a2, a2] - word[a1, a2, a2, a3] - 
      word[a1, a2, a3, a2] - word[a1, a3, a2, a2], 
    word[a3, a1, a2, a3] -> word[a3]*word[a1, a2, a3] - 
      2*word[a1, a2, a3, a3] - word[a1, a3, a2, a3], 
    word[a3, a1, a2, a4] -> word[a3]*word[a1, a2, a4] - 
      word[a1, a2, a3, a4] - word[a1, a2, a4, a3] - word[a1, a3, a2, a4], 
    word[a3, a1, a3, a1] -> word[a1]*word[a3]*word[a1, a3] + 
      word[a1, a3]^2/2 - 2*word[a3]*word[a1, a1, a3] - 
      2*word[a1]*word[a1, a3, a3] + 2*word[a1, a1, a3, a3], 
    word[a3, a1, a3, a2] -> word[a3]*word[a1, a3, a2] - 
      word[a1, a3, a2, a3] - 2*word[a1, a3, a3, a2], 
    word[a3, a1, a3, a3] -> word[a3]*word[a1, a3, a3] - 
      3*word[a1, a3, a3, a3], word[a3, a1, a3, a4] -> 
     word[a3]*word[a1, a3, a4] - 2*word[a1, a3, a3, a4] - 
      word[a1, a3, a4, a3], word[a3, a1, a4, a1] -> 
     word[a1]*word[a3]*word[a1, a4] - 2*word[a3]*word[a1, a1, a4] - 
      word[a1]*word[a1, a3, a4] - word[a1]*word[a1, a4, a3] + 
      2*word[a1, a1, a3, a4] + 2*word[a1, a1, a4, a3] + word[a1, a3, a1, a4], 
    word[a3, a1, a4, a2] -> word[a3]*word[a1, a4, a2] - 
      word[a1, a3, a4, a2] - word[a1, a4, a2, a3] - word[a1, a4, a3, a2], 
    word[a3, a1, a4, a3] -> word[a3]*word[a1, a4, a3] - 
      word[a1, a3, a4, a3] - 2*word[a1, a4, a3, a3], 
    word[a3, a1, a4, a4] -> word[a3]*word[a1, a4, a4] - 
      word[a1, a3, a4, a4] - word[a1, a4, a3, a4] - word[a1, a4, a4, a3], 
    word[a3, a2, a1, a1] -> (word[a1]^2*word[a2]*word[a3])/2 - 
      word[a1]*word[a3]*word[a1, a2] - (word[a1]^2*word[a2, a3])/2 + 
      word[a3]*word[a1, a1, a2] + word[a1]*word[a1, a2, a3] - 
      word[a1, a1, a2, a3], word[a3, a2, a1, a2] -> 
     word[a2]*word[a3]*word[a1, a2] - word[a1, a2]*word[a2, a3] - 
      2*word[a3]*word[a1, a2, a2] + 2*word[a1, a2, a2, a3] + 
      word[a1, a2, a3, a2], word[a3, a2, a1, a3] -> 
     word[a2]*word[a3]*word[a1, a3] - word[a1, a3]*word[a2, a3] - 
      word[a3]*word[a1, a2, a3] - word[a3]*word[a1, a3, a2] + 
      2*word[a1, a2, a3, a3] + word[a1, a3, a2, a3], 
    word[a3, a2, a1, a4] -> word[a2]*word[a3]*word[a1, a4] - 
      word[a1, a4]*word[a2, a3] - word[a3]*word[a1, a2, a4] - 
      word[a3]*word[a1, a4, a2] + word[a1, a2, a3, a4] + 
      word[a1, a2, a4, a3] + word[a1, a4, a2, a3], 
    word[a3, a2, a2, a1] -> (word[a1]*word[a2]^2*word[a3])/2 - 
      word[a2]*word[a3]*word[a1, a2] - word[a1]*word[a2]*word[a2, a3] + 
      word[a1, a2]*word[a2, a3] + word[a3]*word[a1, a2, a2] + 
      word[a1]*word[a2, a2, a3] - word[a1, a2, a2, a3], 
    word[a3, a2, a2, a2] -> (word[a2]^3*word[a3])/6 - 
      (word[a2]^2*word[a2, a3])/2 + word[a2]*word[a2, a2, a3] - 
      word[a2, a2, a2, a3], word[a3, a2, a2, a3] -> 
     (-word[a2, a3]^2 + 2*word[a3]*word[a2, a2, a3])/2, 
    word[a3, a2, a2, a4] -> word[a3]*word[a2, a2, a4] - 
      word[a2, a2, a3, a4] - word[a2, a2, a4, a3] - word[a2, a3, a2, a4], 
    word[a3, a2, a3, a1] -> -(word[a2]*word[a3]*word[a1, a3]) + 
      word[a1]*word[a3]*word[a2, a3] + word[a1, a3]*word[a2, a3] + 
      word[a3]*word[a1, a3, a2] - 2*word[a1]*word[a2, a3, a3] - 
      word[a1, a3, a2, a3], word[a3, a2, a3, a2] -> 
     word[a2]*word[a3]*word[a2, a3] + word[a2, a3]^2/2 - 
      2*word[a3]*word[a2, a2, a3] - 2*word[a2]*word[a2, a3, a3] + 
      2*word[a2, a2, a3, a3], word[a3, a2, a3, a3] -> 
     word[a3]*word[a2, a3, a3] - 3*word[a2, a3, a3, a3], 
    word[a3, a2, a3, a4] -> word[a3]*word[a2, a3, a4] - 
      2*word[a2, a3, a3, a4] - word[a2, a3, a4, a3], 
    word[a3, a2, a4, a1] -> -(word[a2]*word[a3]*word[a1, a4]) + 
      word[a1, a4]*word[a2, a3] + word[a1]*word[a3]*word[a2, a4] + 
      word[a3]*word[a1, a4, a2] - word[a1]*word[a2, a3, a4] - 
      word[a1]*word[a2, a4, a3] - word[a1, a4, a2, a3], 
    word[a3, a2, a4, a2] -> word[a2]*word[a3]*word[a2, a4] - 
      2*word[a3]*word[a2, a2, a4] - word[a2]*word[a2, a3, a4] - 
      word[a2]*word[a2, a4, a3] + 2*word[a2, a2, a3, a4] + 
      2*word[a2, a2, a4, a3] + word[a2, a3, a2, a4], 
    word[a3, a2, a4, a3] -> word[a3]*word[a2, a4, a3] - 
      word[a2, a3, a4, a3] - 2*word[a2, a4, a3, a3], 
    word[a3, a2, a4, a4] -> word[a3]*word[a2, a4, a4] - 
      word[a2, a3, a4, a4] - word[a2, a4, a3, a4] - word[a2, a4, a4, a3], 
    word[a3, a3, a1, a1] -> (word[a1]^2*word[a3]^2)/4 - 
      word[a1]*word[a3]*word[a1, a3] + word[a3]*word[a1, a1, a3] + 
      word[a1]*word[a1, a3, a3] - word[a1, a1, a3, a3], 
    word[a3, a3, a1, a2] -> (word[a3]^2*word[a1, a2])/2 - 
      word[a3]*word[a1, a2, a3] - word[a3]*word[a1, a3, a2] + 
      word[a1, a2, a3, a3] + word[a1, a3, a2, a3] + word[a1, a3, a3, a2], 
    word[a3, a3, a1, a3] -> (word[a3]^2*word[a1, a3])/2 - 
      2*word[a3]*word[a1, a3, a3] + 3*word[a1, a3, a3, a3], 
    word[a3, a3, a1, a4] -> (word[a3]^2*word[a1, a4])/2 - 
      word[a3]*word[a1, a3, a4] - word[a3]*word[a1, a4, a3] + 
      word[a1, a3, a3, a4] + word[a1, a3, a4, a3] + word[a1, a4, a3, a3], 
    word[a3, a3, a2, a1] -> (word[a1]*word[a2]*word[a3]^2)/2 - 
      (word[a3]^2*word[a1, a2])/2 - word[a1]*word[a3]*word[a2, a3] + 
      word[a3]*word[a1, a2, a3] + word[a1]*word[a2, a3, a3] - 
      word[a1, a2, a3, a3], word[a3, a3, a2, a2] -> 
     (word[a2]^2*word[a3]^2)/4 - word[a2]*word[a3]*word[a2, a3] + 
      word[a3]*word[a2, a2, a3] + word[a2]*word[a2, a3, a3] - 
      word[a2, a2, a3, a3], word[a3, a3, a2, a3] -> 
     (word[a3]^2*word[a2, a3])/2 - 2*word[a3]*word[a2, a3, a3] + 
      3*word[a2, a3, a3, a3], word[a3, a3, a2, a4] -> 
     (word[a3]^2*word[a2, a4])/2 - word[a3]*word[a2, a3, a4] - 
      word[a3]*word[a2, a4, a3] + word[a2, a3, a3, a4] + 
      word[a2, a3, a4, a3] + word[a2, a4, a3, a3], 
    word[a3, a3, a3, a1] -> (word[a1]*word[a3]^3)/6 - 
      (word[a3]^2*word[a1, a3])/2 + word[a3]*word[a1, a3, a3] - 
      word[a1, a3, a3, a3], word[a3, a3, a3, a2] -> 
     (word[a2]*word[a3]^3)/6 - (word[a3]^2*word[a2, a3])/2 + 
      word[a3]*word[a2, a3, a3] - word[a2, a3, a3, a3], 
    word[a3, a3, a3, a3] -> word[a3]^4/24, word[a3, a3, a4, a1] -> 
     (-(word[a3]^2*word[a1, a4]) + 2*word[a3]*word[a1, a4, a3] + 
       2*word[a1]*word[a3, a3, a4] - 2*word[a1, a4, a3, a3])/2, 
    word[a3, a3, a4, a2] -> (-(word[a3]^2*word[a2, a4]) + 
       2*word[a3]*word[a2, a4, a3] + 2*word[a2]*word[a3, a3, a4] - 
       2*word[a2, a4, a3, a3])/2, word[a3, a3, a4, a3] -> 
     word[a3]*word[a3, a3, a4] - 3*word[a3, a3, a3, a4], 
    word[a3, a4, a1, a1] -> -(word[a1]*word[a3]*word[a1, a4]) + 
      (word[a1]^2*word[a3, a4])/2 + word[a3]*word[a1, a1, a4] + 
      word[a1]*word[a1, a4, a3] - word[a1, a1, a4, a3], 
    word[a3, a4, a1, a2] -> word[a1, a2]*word[a3, a4] - 
      word[a3]*word[a1, a2, a4] - word[a3]*word[a1, a4, a2] + 
      word[a1, a2, a4, a3] + word[a1, a4, a2, a3] + word[a1, a4, a3, a2], 
    word[a3, a4, a1, a3] -> word[a1, a3]*word[a3, a4] - 
      word[a3]*word[a1, a3, a4] - word[a3]*word[a1, a4, a3] + 
      word[a1, a3, a4, a3] + 2*word[a1, a4, a3, a3], 
    word[a3, a4, a1, a4] -> word[a1, a4]*word[a3, a4] - 
      2*word[a3]*word[a1, a4, a4] + word[a1, a4, a3, a4] + 
      2*word[a1, a4, a4, a3], word[a3, a4, a2, a1] -> 
     -(word[a1]*word[a3]*word[a2, a4]) + word[a1]*word[a2]*word[a3, a4] - 
      word[a1, a2]*word[a3, a4] + word[a3]*word[a1, a2, a4] + 
      word[a1]*word[a2, a4, a3] - word[a1, a2, a4, a3], 
    word[a3, a4, a2, a2] -> -(word[a2]*word[a3]*word[a2, a4]) + 
      (word[a2]^2*word[a3, a4])/2 + word[a3]*word[a2, a2, a4] + 
      word[a2]*word[a2, a4, a3] - word[a2, a2, a4, a3], 
    word[a3, a4, a2, a3] -> word[a2, a3]*word[a3, a4] - 
      word[a3]*word[a2, a3, a4] - word[a3]*word[a2, a4, a3] + 
      word[a2, a3, a4, a3] + 2*word[a2, a4, a3, a3], 
    word[a3, a4, a2, a4] -> word[a2, a4]*word[a3, a4] - 
      2*word[a3]*word[a2, a4, a4] + word[a2, a4, a3, a4] + 
      2*word[a2, a4, a4, a3], word[a3, a4, a3, a1] -> 
     word[a1]*word[a3]*word[a3, a4] - word[a1, a3]*word[a3, a4] + 
      word[a3]*word[a1, a3, a4] - 2*word[a1]*word[a3, a3, a4] - 
      word[a1, a3, a4, a3], word[a3, a4, a3, a2] -> 
     word[a2]*word[a3]*word[a3, a4] - word[a2, a3]*word[a3, a4] + 
      word[a3]*word[a2, a3, a4] - 2*word[a2]*word[a3, a3, a4] - 
      word[a2, a3, a4, a3], word[a3, a4, a3, a3] -> 
     (word[a3]^2*word[a3, a4])/2 - 2*word[a3]*word[a3, a3, a4] + 
      3*word[a3, a3, a3, a4], word[a3, a4, a3, a4] -> 
     (word[a3, a4]^2 - 4*word[a3, a3, a4, a4])/2, word[a3, a4, a4, a1] -> 
     -(word[a1, a4]*word[a3, a4]) + word[a3]*word[a1, a4, a4] + 
      word[a1]*word[a3, a4, a4] - word[a1, a4, a4, a3], 
    word[a3, a4, a4, a2] -> -(word[a2, a4]*word[a3, a4]) + 
      word[a3]*word[a2, a4, a4] + word[a2]*word[a3, a4, a4] - 
      word[a2, a4, a4, a3], word[a3, a4, a4, a3] -> 
     (-word[a3, a4]^2 + 2*word[a3]*word[a3, a4, a4])/2, 
    word[a4, a1, a1, a1] -> (word[a1]^3*word[a4])/6 - 
      (word[a1]^2*word[a1, a4])/2 + word[a1]*word[a1, a1, a4] - 
      word[a1, a1, a1, a4], word[a4, a1, a1, a2] -> 
     -(word[a1, a2]*word[a1, a4]) + word[a4]*word[a1, a1, a2] + 
      word[a1, a1, a2, a4] + word[a1, a1, a4, a2] + word[a1, a2, a1, a4], 
    word[a4, a1, a1, a3] -> -(word[a1, a3]*word[a1, a4]) + 
      word[a4]*word[a1, a1, a3] + word[a1, a1, a3, a4] + 
      word[a1, a1, a4, a3] + word[a1, a3, a1, a4], 
    word[a4, a1, a1, a4] -> (-word[a1, a4]^2 + 2*word[a4]*word[a1, a1, a4])/
      2, word[a4, a1, a2, a1] -> word[a1]*word[a4]*word[a1, a2] + 
      word[a1, a2]*word[a1, a4] - 2*word[a4]*word[a1, a1, a2] - 
      word[a1]*word[a1, a2, a4] - word[a1]*word[a1, a4, a2] - 
      word[a1, a2, a1, a4], word[a4, a1, a2, a2] -> 
     word[a4]*word[a1, a2, a2] - word[a1, a2, a2, a4] - 
      word[a1, a2, a4, a2] - word[a1, a4, a2, a2], 
    word[a4, a1, a2, a3] -> word[a4]*word[a1, a2, a3] - 
      word[a1, a2, a3, a4] - word[a1, a2, a4, a3] - word[a1, a4, a2, a3], 
    word[a4, a1, a2, a4] -> word[a4]*word[a1, a2, a4] - 
      2*word[a1, a2, a4, a4] - word[a1, a4, a2, a4], 
    word[a4, a1, a3, a1] -> word[a1]*word[a4]*word[a1, a3] + 
      word[a1, a3]*word[a1, a4] - 2*word[a4]*word[a1, a1, a3] - 
      word[a1]*word[a1, a3, a4] - word[a1]*word[a1, a4, a3] - 
      word[a1, a3, a1, a4], word[a4, a1, a3, a2] -> 
     word[a4]*word[a1, a3, a2] - word[a1, a3, a2, a4] - 
      word[a1, a3, a4, a2] - word[a1, a4, a3, a2], 
    word[a4, a1, a3, a3] -> word[a4]*word[a1, a3, a3] - 
      word[a1, a3, a3, a4] - word[a1, a3, a4, a3] - word[a1, a4, a3, a3], 
    word[a4, a1, a3, a4] -> word[a4]*word[a1, a3, a4] - 
      2*word[a1, a3, a4, a4] - word[a1, a4, a3, a4], 
    word[a4, a1, a4, a1] -> word[a1]*word[a4]*word[a1, a4] + 
      word[a1, a4]^2/2 - 2*word[a4]*word[a1, a1, a4] - 
      2*word[a1]*word[a1, a4, a4] + 2*word[a1, a1, a4, a4], 
    word[a4, a1, a4, a2] -> word[a4]*word[a1, a4, a2] - 
      word[a1, a4, a2, a4] - 2*word[a1, a4, a4, a2], 
    word[a4, a1, a4, a3] -> word[a4]*word[a1, a4, a3] - 
      word[a1, a4, a3, a4] - 2*word[a1, a4, a4, a3], 
    word[a4, a1, a4, a4] -> word[a4]*word[a1, a4, a4] - 
      3*word[a1, a4, a4, a4], word[a4, a2, a1, a1] -> 
     (word[a1]^2*word[a2]*word[a4])/2 - word[a1]*word[a4]*word[a1, a2] - 
      (word[a1]^2*word[a2, a4])/2 + word[a4]*word[a1, a1, a2] + 
      word[a1]*word[a1, a2, a4] - word[a1, a1, a2, a4], 
    word[a4, a2, a1, a2] -> word[a2]*word[a4]*word[a1, a2] - 
      word[a1, a2]*word[a2, a4] - 2*word[a4]*word[a1, a2, a2] + 
      2*word[a1, a2, a2, a4] + word[a1, a2, a4, a2], 
    word[a4, a2, a1, a3] -> word[a2]*word[a4]*word[a1, a3] - 
      word[a1, a3]*word[a2, a4] - word[a4]*word[a1, a2, a3] - 
      word[a4]*word[a1, a3, a2] + word[a1, a2, a3, a4] + 
      word[a1, a2, a4, a3] + word[a1, a3, a2, a4], 
    word[a4, a2, a1, a4] -> word[a2]*word[a4]*word[a1, a4] - 
      word[a1, a4]*word[a2, a4] - word[a4]*word[a1, a2, a4] - 
      word[a4]*word[a1, a4, a2] + 2*word[a1, a2, a4, a4] + 
      word[a1, a4, a2, a4], word[a4, a2, a2, a1] -> 
     (word[a1]*word[a2]^2*word[a4])/2 - word[a2]*word[a4]*word[a1, a2] - 
      word[a1]*word[a2]*word[a2, a4] + word[a1, a2]*word[a2, a4] + 
      word[a4]*word[a1, a2, a2] + word[a1]*word[a2, a2, a4] - 
      word[a1, a2, a2, a4], word[a4, a2, a2, a2] -> 
     (word[a2]^3*word[a4])/6 - (word[a2]^2*word[a2, a4])/2 + 
      word[a2]*word[a2, a2, a4] - word[a2, a2, a2, a4], 
    word[a4, a2, a2, a3] -> -(word[a2, a3]*word[a2, a4]) + 
      word[a4]*word[a2, a2, a3] + word[a2, a2, a3, a4] + 
      word[a2, a2, a4, a3] + word[a2, a3, a2, a4], 
    word[a4, a2, a2, a4] -> (-word[a2, a4]^2 + 2*word[a4]*word[a2, a2, a4])/
      2, word[a4, a2, a3, a1] -> -(word[a2]*word[a4]*word[a1, a3]) + 
      word[a1]*word[a4]*word[a2, a3] + word[a1, a3]*word[a2, a4] + 
      word[a4]*word[a1, a3, a2] - word[a1]*word[a2, a3, a4] - 
      word[a1]*word[a2, a4, a3] - word[a1, a3, a2, a4], 
    word[a4, a2, a3, a2] -> word[a2]*word[a4]*word[a2, a3] + 
      word[a2, a3]*word[a2, a4] - 2*word[a4]*word[a2, a2, a3] - 
      word[a2]*word[a2, a3, a4] - word[a2]*word[a2, a4, a3] - 
      word[a2, a3, a2, a4], word[a4, a2, a3, a3] -> 
     word[a4]*word[a2, a3, a3] - word[a2, a3, a3, a4] - 
      word[a2, a3, a4, a3] - word[a2, a4, a3, a3], 
    word[a4, a2, a3, a4] -> word[a4]*word[a2, a3, a4] - 
      2*word[a2, a3, a4, a4] - word[a2, a4, a3, a4], 
    word[a4, a2, a4, a1] -> -(word[a2]*word[a4]*word[a1, a4]) + 
      word[a1]*word[a4]*word[a2, a4] + word[a1, a4]*word[a2, a4] + 
      word[a4]*word[a1, a4, a2] - 2*word[a1]*word[a2, a4, a4] - 
      word[a1, a4, a2, a4], word[a4, a2, a4, a2] -> 
     word[a2]*word[a4]*word[a2, a4] + word[a2, a4]^2/2 - 
      2*word[a4]*word[a2, a2, a4] - 2*word[a2]*word[a2, a4, a4] + 
      2*word[a2, a2, a4, a4], word[a4, a2, a4, a3] -> 
     word[a4]*word[a2, a4, a3] - word[a2, a4, a3, a4] - 
      2*word[a2, a4, a4, a3], word[a4, a2, a4, a4] -> 
     word[a4]*word[a2, a4, a4] - 3*word[a2, a4, a4, a4], 
    word[a4, a3, a1, a1] -> (word[a1]^2*word[a3]*word[a4])/2 - 
      word[a1]*word[a4]*word[a1, a3] - (word[a1]^2*word[a3, a4])/2 + 
      word[a4]*word[a1, a1, a3] + word[a1]*word[a1, a3, a4] - 
      word[a1, a1, a3, a4], word[a4, a3, a1, a2] -> 
     word[a3]*word[a4]*word[a1, a2] - word[a1, a2]*word[a3, a4] - 
      word[a4]*word[a1, a2, a3] - word[a4]*word[a1, a3, a2] + 
      word[a1, a2, a3, a4] + word[a1, a3, a2, a4] + word[a1, a3, a4, a2], 
    word[a4, a3, a1, a3] -> word[a3]*word[a4]*word[a1, a3] - 
      word[a1, a3]*word[a3, a4] - 2*word[a4]*word[a1, a3, a3] + 
      2*word[a1, a3, a3, a4] + word[a1, a3, a4, a3], 
    word[a4, a3, a1, a4] -> word[a3]*word[a4]*word[a1, a4] - 
      word[a1, a4]*word[a3, a4] - word[a4]*word[a1, a3, a4] - 
      word[a4]*word[a1, a4, a3] + 2*word[a1, a3, a4, a4] + 
      word[a1, a4, a3, a4], word[a4, a3, a2, a1] -> 
     word[a1]*word[a2]*word[a3]*word[a4] - word[a3]*word[a4]*word[a1, a2] - 
      word[a1]*word[a4]*word[a2, a3] - word[a1]*word[a2]*word[a3, a4] + 
      word[a1, a2]*word[a3, a4] + word[a4]*word[a1, a2, a3] + 
      word[a1]*word[a2, a3, a4] - word[a1, a2, a3, a4], 
    word[a4, a3, a2, a2] -> (word[a2]^2*word[a3]*word[a4])/2 - 
      word[a2]*word[a4]*word[a2, a3] - (word[a2]^2*word[a3, a4])/2 + 
      word[a4]*word[a2, a2, a3] + word[a2]*word[a2, a3, a4] - 
      word[a2, a2, a3, a4], word[a4, a3, a2, a3] -> 
     word[a3]*word[a4]*word[a2, a3] - word[a2, a3]*word[a3, a4] - 
      2*word[a4]*word[a2, a3, a3] + 2*word[a2, a3, a3, a4] + 
      word[a2, a3, a4, a3], word[a4, a3, a2, a4] -> 
     word[a3]*word[a4]*word[a2, a4] - word[a2, a4]*word[a3, a4] - 
      word[a4]*word[a2, a3, a4] - word[a4]*word[a2, a4, a3] + 
      2*word[a2, a3, a4, a4] + word[a2, a4, a3, a4], 
    word[a4, a3, a3, a1] -> (word[a1]*word[a3]^2*word[a4])/2 - 
      word[a3]*word[a4]*word[a1, a3] - word[a1]*word[a3]*word[a3, a4] + 
      word[a1, a3]*word[a3, a4] + word[a4]*word[a1, a3, a3] + 
      word[a1]*word[a3, a3, a4] - word[a1, a3, a3, a4], 
    word[a4, a3, a3, a2] -> (word[a2]*word[a3]^2*word[a4])/2 - 
      word[a3]*word[a4]*word[a2, a3] - word[a2]*word[a3]*word[a3, a4] + 
      word[a2, a3]*word[a3, a4] + word[a4]*word[a2, a3, a3] + 
      word[a2]*word[a3, a3, a4] - word[a2, a3, a3, a4], 
    word[a4, a3, a3, a3] -> (word[a3]^3*word[a4])/6 - 
      (word[a3]^2*word[a3, a4])/2 + word[a3]*word[a3, a3, a4] - 
      word[a3, a3, a3, a4], word[a4, a3, a3, a4] -> 
     (-word[a3, a4]^2 + 2*word[a4]*word[a3, a3, a4])/2, 
    word[a4, a3, a4, a1] -> -(word[a3]*word[a4]*word[a1, a4]) + 
      word[a1]*word[a4]*word[a3, a4] + word[a1, a4]*word[a3, a4] + 
      word[a4]*word[a1, a4, a3] - 2*word[a1]*word[a3, a4, a4] - 
      word[a1, a4, a3, a4], word[a4, a3, a4, a2] -> 
     -(word[a3]*word[a4]*word[a2, a4]) + word[a2]*word[a4]*word[a3, a4] + 
      word[a2, a4]*word[a3, a4] + word[a4]*word[a2, a4, a3] - 
      2*word[a2]*word[a3, a4, a4] - word[a2, a4, a3, a4], 
    word[a4, a3, a4, a3] -> word[a3]*word[a4]*word[a3, a4] + 
      word[a3, a4]^2/2 - 2*word[a4]*word[a3, a3, a4] - 
      2*word[a3]*word[a3, a4, a4] + 2*word[a3, a3, a4, a4], 
    word[a4, a3, a4, a4] -> word[a4]*word[a3, a4, a4] - 
      3*word[a3, a4, a4, a4], word[a4, a4, a1, a1] -> 
     (word[a1]^2*word[a4]^2)/4 - word[a1]*word[a4]*word[a1, a4] + 
      word[a4]*word[a1, a1, a4] + word[a1]*word[a1, a4, a4] - 
      word[a1, a1, a4, a4], word[a4, a4, a1, a2] -> 
     (word[a4]^2*word[a1, a2])/2 - word[a4]*word[a1, a2, a4] - 
      word[a4]*word[a1, a4, a2] + word[a1, a2, a4, a4] + 
      word[a1, a4, a2, a4] + word[a1, a4, a4, a2], 
    word[a4, a4, a1, a3] -> (word[a4]^2*word[a1, a3])/2 - 
      word[a4]*word[a1, a3, a4] - word[a4]*word[a1, a4, a3] + 
      word[a1, a3, a4, a4] + word[a1, a4, a3, a4] + word[a1, a4, a4, a3], 
    word[a4, a4, a1, a4] -> (word[a4]^2*word[a1, a4])/2 - 
      2*word[a4]*word[a1, a4, a4] + 3*word[a1, a4, a4, a4], 
    word[a4, a4, a2, a1] -> (word[a1]*word[a2]*word[a4]^2)/2 - 
      (word[a4]^2*word[a1, a2])/2 - word[a1]*word[a4]*word[a2, a4] + 
      word[a4]*word[a1, a2, a4] + word[a1]*word[a2, a4, a4] - 
      word[a1, a2, a4, a4], word[a4, a4, a2, a2] -> 
     (word[a2]^2*word[a4]^2)/4 - word[a2]*word[a4]*word[a2, a4] + 
      word[a4]*word[a2, a2, a4] + word[a2]*word[a2, a4, a4] - 
      word[a2, a2, a4, a4], word[a4, a4, a2, a3] -> 
     (word[a4]^2*word[a2, a3])/2 - word[a4]*word[a2, a3, a4] - 
      word[a4]*word[a2, a4, a3] + word[a2, a3, a4, a4] + 
      word[a2, a4, a3, a4] + word[a2, a4, a4, a3], 
    word[a4, a4, a2, a4] -> (word[a4]^2*word[a2, a4])/2 - 
      2*word[a4]*word[a2, a4, a4] + 3*word[a2, a4, a4, a4], 
    word[a4, a4, a3, a1] -> (word[a1]*word[a3]*word[a4]^2)/2 - 
      (word[a4]^2*word[a1, a3])/2 - word[a1]*word[a4]*word[a3, a4] + 
      word[a4]*word[a1, a3, a4] + word[a1]*word[a3, a4, a4] - 
      word[a1, a3, a4, a4], word[a4, a4, a3, a2] -> 
     (word[a2]*word[a3]*word[a4]^2)/2 - (word[a4]^2*word[a2, a3])/2 - 
      word[a2]*word[a4]*word[a3, a4] + word[a4]*word[a2, a3, a4] + 
      word[a2]*word[a3, a4, a4] - word[a2, a3, a4, a4], 
    word[a4, a4, a3, a3] -> (word[a3]^2*word[a4]^2)/4 - 
      word[a3]*word[a4]*word[a3, a4] + word[a4]*word[a3, a3, a4] + 
      word[a3]*word[a3, a4, a4] - word[a3, a3, a4, a4], 
    word[a4, a4, a3, a4] -> (word[a4]^2*word[a3, a4])/2 - 
      2*word[a4]*word[a3, a4, a4] + 3*word[a3, a4, a4, a4], 
    word[a4, a4, a4, a1] -> (word[a1]*word[a4]^3)/6 - 
      (word[a4]^2*word[a1, a4])/2 + word[a4]*word[a1, a4, a4] - 
      word[a1, a4, a4, a4], word[a4, a4, a4, a2] -> 
     (word[a2]*word[a4]^3)/6 - (word[a4]^2*word[a2, a4])/2 + 
      word[a4]*word[a2, a4, a4] - word[a2, a4, a4, a4], 
    word[a4, a4, a4, a3] -> (word[a3]*word[a4]^3)/6 - 
      (word[a4]^2*word[a3, a4])/2 + word[a4]*word[a3, a4, a4] - 
      word[a3, a4, a4, a4], word[a4, a4, a4, a4] -> word[a4]^4/24}
