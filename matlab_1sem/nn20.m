function a = nn20 (n, q)
    a=[];
    while n
        a(end+1) = mod(n, q);
        n = fix(n/q);
    end
    a = fliplr(a);
end