f = @(x, a, eps) logorithm(x, a, eps)

function Y = logorithm (x, a, eps)
    y = 0;
    z = x;
    t = 1;
    %a^y * z^t = x
    while abs(t) >= eps || z<=1/a || z>=a
        if z >= a
            z /= a;
            y += t;
        elseif z <= 1/a
            z *= a;
            y -= t;
        else
            z *= z;
            t /= 2;
        end
    end
    Y = y;
end