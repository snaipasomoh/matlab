function D = nn49 (n)
    if size(n) == 1
        D = n(1);
    else
        D = euqlid(n(1), n(2));
        for i = [3:size(n)]
            D = euqlid(D, n(i));
        end
    end
end

function d = euqlid (a, b)
    while a ~= 0
        r = mod(b, a);
        b = a;
        a = r;
    end
    d = b;
end