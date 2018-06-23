drawDiff = @(x, dx) gr(x, dx)
function gr(X, dX)
    figure
    differ = @(x, dx) abs((sin(x+dx)-sin(x-dx))/(2*dx)-cos(x))
    plot(X, differ(X, dX))
end