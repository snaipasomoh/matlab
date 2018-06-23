function a = nn25 (n)
    for i = [0:n]
        a(i+1) = factorial(n)/factorial(i)/factorial(n-i);
    end
end