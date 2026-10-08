LyndonDecompositionRules3 = {word[a1, a1] -> word[a1]^2/2, 
    word[a2, a1] -> word[a1]*word[a2] - word[a1, a2], 
    word[a2, a2] -> word[a2]^2/2, word[a3, a1] -> word[a1]*word[a3] - 
      word[a1, a3], word[a3, a2] -> word[a2]*word[a3] - word[a2, a3], 
    word[a3, a3] -> word[a3]^2/2, word[a1, a1, a1] -> word[a1]^3/6, 
    word[a1, a2, a1] -> word[a1]*word[a1, a2] - 2*word[a1, a1, a2], 
    word[a1, a3, a1] -> word[a1]*word[a1, a3] - 2*word[a1, a1, a3], 
    word[a2, a1, a1] -> (word[a1]^2*word[a2])/2 - word[a1]*word[a1, a2] + 
      word[a1, a1, a2], word[a2, a1, a2] -> word[a2]*word[a1, a2] - 
      2*word[a1, a2, a2], word[a2, a1, a3] -> word[a2]*word[a1, a3] - 
      word[a1, a2, a3] - word[a1, a3, a2], word[a2, a2, a1] -> 
     (word[a1]*word[a2]^2)/2 - word[a2]*word[a1, a2] + word[a1, a2, a2], 
    word[a2, a2, a2] -> word[a2]^3/6, word[a2, a3, a1] -> 
     -(word[a2]*word[a1, a3]) + word[a1]*word[a2, a3] + word[a1, a3, a2], 
    word[a2, a3, a2] -> word[a2]*word[a2, a3] - 2*word[a2, a2, a3], 
    word[a3, a1, a1] -> (word[a1]^2*word[a3])/2 - word[a1]*word[a1, a3] + 
      word[a1, a1, a3], word[a3, a1, a2] -> word[a3]*word[a1, a2] - 
      word[a1, a2, a3] - word[a1, a3, a2], word[a3, a1, a3] -> 
     word[a3]*word[a1, a3] - 2*word[a1, a3, a3], word[a3, a2, a1] -> 
     word[a1]*word[a2]*word[a3] - word[a3]*word[a1, a2] - 
      word[a1]*word[a2, a3] + word[a1, a2, a3], word[a3, a2, a2] -> 
     (word[a2]^2*word[a3])/2 - word[a2]*word[a2, a3] + word[a2, a2, a3], 
    word[a3, a2, a3] -> word[a3]*word[a2, a3] - 2*word[a2, a3, a3], 
    word[a3, a3, a1] -> (word[a1]*word[a3]^2)/2 - word[a3]*word[a1, a3] + 
      word[a1, a3, a3], word[a3, a3, a2] -> (word[a2]*word[a3]^2)/2 - 
      word[a3]*word[a2, a3] + word[a2, a3, a3], word[a3, a3, a3] -> 
     word[a3]^3/6}
