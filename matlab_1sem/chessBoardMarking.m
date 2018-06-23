function chessBoardMarking (R)
    R.mark()
    flag = calibrate(R);
    direction = 'o';
    flag = moveAndMark(R, direction, flag);
    while ~R.is_bord('n')
        R.step('n')
        flag = ~flag;
        direction = changeDirection(direction);
        flag = moveAndMark(R, direction, flag);
    end
end

function Flag = calibrate (R)
    x = calculateCells(R,'o');
    yCoord = calculateCells(R,'s');
    fieldLength = calculateCells(R,'w');
    xCoord = fieldLength-x;
    if mod(yCoord, 2) == 0
        sum = fieldLength*yCoord+xCoord;
    else
        sum = fieldLength*yCoord+fieldLength-xCoord-1;
    end
    if mod(sum, 2) == 0
        Flag = 1;
    else
        Flag = 0;
    end
end

function N = calculateCells (R, direction)
    x = 0;
    while ~R.is_bord(direction)
        R.step(direction)
        x++;
    end
    N = x;
end

function Flag = moveAndMark (R, direction, flag)
    if flag
        R.mark()
    end
    while ~R.is_bord(direction)
        R.step(direction)
        flag = ~flag;
        if flag
            R.mark()
        end
    end
    Flag = flag;
end

function Direction = changeDirection (direction)
    if direction == 'w'
        Direction = 'o';
    else
        Direction = 'w';
    end
end