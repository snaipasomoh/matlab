function Ans = n18 (a)
    A = bisect(@(x) (cos(x)-x), -10, 10, 0.00001);
    B = bisect(@(x) (cos(x)-a*x), -10, 10, 0.00001);
    Ans = [A B];
    figure
    hold on
    for b = [-10:0.1:10]
        plot(b, bisect(@(x) (cos(x)-b*x), -10, 10, 0.00001));
    end
end

function X = bisect (f, a, b, eps)
    [a b] = deal(min(a, b), max(a, b));
    while b-a>eps
        middle = (a+b)/2;
        if sign(f(a)) ~= sign(f(middle))
            b = middle;
        else
            a = middle;
        end
    end
    X = (a+b)/2;
end