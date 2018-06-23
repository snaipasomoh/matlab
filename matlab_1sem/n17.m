binet = @(n) round((((1+sqrt(5))/2).^n)/sqrt(5))

fibMatrix = @(n) ([0 1]*[0 1; 1 1]^n)(1)