function A = nn50 (m, n)
    a = m;
    b = n;
    x1 = 1;
    y1 = 0;
    x2 = 0;
    y2 = 1;
    %мнд(a, b) = мнд(m, n)
    %a = x1*m+y1*n
    %b = x2*m+y2*n
    while b~=0
        q = fix(a/b);
        r = mod(a, b);
        a = b;
        b = r;
        
        t = x2;
        x2 = x1-q*x2;
        x1 = t;
        
        t = y2;
        y2 = y1-q*y2;
        y1 = t;
    end
    d = a;
    x = x1;
    y = y1;
    A = [d x y];
end