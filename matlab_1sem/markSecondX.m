function markSecondX (R)
    y1 = calculateMoves(R, 'n');
    y2 = calculateMoves(R, 's');
    for i = [1:y2-y1]
        diagonalStep(R, 'n');
    end
    x1 = calculateMoves(R, 'w');
    x2 = calculateMoves(R, 'o');
    for i = [1:x2-x1]
        diagonalStep(R, 'w');
    end
end

function Number = calculateMoves (R, direction)
    if direction == 'n'
        secondDirection = 'w';
    elseif direction == 'o'
        secondDirection = 'n';
    elseif direction == 's';
        secondDirection = 'o';
    else
        secondDirection = 's';
    end
    number = 0;
    while (~R.is_bord(direction)) && (~R.is_bord(secondDirection))
        R.mark()
        diagonalStep(R, direction)
        R.mark()
        number++;
    end
    Number = number;
end

function diagonalStep(R, direction)
    if direction == 'n'
        secondDirection = 'w';
    elseif direction == 'o'
        secondDirection = 'n';
    elseif direction == 's';
        secondDirection = 'o';
    else
        secondDirection = 's';
    end
    R.step(direction)
    R.step(secondDirection)
end