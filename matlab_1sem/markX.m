function markX (R)
    y1 = calculateMoves(R, 'n');
    y2 = calculateMoves(R, 's');
    for i = [1:y2-y1]
        R.step('n')
    end
    x1 = calculateMoves(R, 'w');
    x2 = calculateMoves(R, 'o');
    for i = [1:x2-x1]
        R.step('w')
    end
end
    
function Number = calculateMoves (R, direction)
    number = 0;
    while ~R.is_bord(direction)
        R.mark()
        R.step(direction)
        R.mark()
        number++;
    end
    Number = number;
end