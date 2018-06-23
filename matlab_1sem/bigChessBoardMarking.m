function bigChessBoardMarking (R, n)
    XCOORD = 0;
    YCOORD = 0;
    [XCOORD, YCOORD] = markRow(R, n, XCOORD, YCOORD);
    while ~(R.is_bord('n') && (R.is_bord('o') || R.is_bord('w')))
        [XCOORD, YCOORD] = trueStep(R, 'n', XCOORD, YCOORD);
        [XCOORD, YCOORD] = markRow(R, n, XCOORD, YCOORD);
    end
end

function [XCoord, YCoord] = markRow (R, n, xCoord, yCoord)
    if R.is_bord('o')
        direction = 'w';
    else
        direction = 'o';
    end
    if needMark(n, xCoord, yCoord)
        R.mark()
    end
    while ~R.is_bord(direction)
        [xCoord, yCoord] = trueStep(R, direction, xCoord, yCoord);
        if needMark(n, xCoord, yCoord)
            R.mark()
        end
    end
    XCoord = xCoord;
    YCoord = yCoord;
end

function Mark = needMark (n, xCoord, yCoord)
    if mod(fix(xCoord/n)+fix(yCoord/n), 2)
        Mark = 0;
    else
        Mark = 1;
    end
end

function [XCoord, YCoord] = trueStep (R, direction, xCoord, yCoord)
    if direction == 'n'
        XCoord = xCoord;
        YCoord = yCoord + 1;
    elseif direction == 'o'
        XCoord = xCoord + 1;
        YCoord = yCoord;
    elseif direction == 's'
        XCoord = xCoord;
        YCoord = yCoord - 1;
    else
        XCoord = xCoord - 1;
        YCoord = yCoord;
    end
    R.step(direction)
end