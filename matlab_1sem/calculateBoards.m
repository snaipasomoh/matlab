function calculateBoards (R)
    [HIGHT, LENGTH] = calibrate(R);
    XCOORD = 0;
    YCOORD = 0;
    BOARDS = 0;
    [XCOORD, YCOORD, BOARDS] = scanHor(R, LENGTH, HIGHT, XCOORD, YCOORD);
    BOARDS
end

function [Hight, Length] = calibrate (R)
    while ~R.is_bord('n') || ~R.is_bord('o')
        if ~R.is_bord('n')
            R.step('n')
        end
        if ~R.is_bord('o')
            R.step('o')
        end
    end
    length = 0;
    hight = 0;
    while ~R.is_bord('s')
        hight++;
        R.step('s')
    end
    while ~R.is_bord('w')
        length++;
        R.step('w')
    end
    Hight = hight;
    Length = length;
end

function [XCoord, YCoord, Boards] = scanHor (R, length, hight, xCoord, yCoord)
    boards = 0;
    dBoards = 0;
    dXCoord = 1;
    for i = [1:length+1]
        vertBoards{i} = 0;
    end
    for i = [0:hight]
        [xCoord, yCoord, dBoards, vertBoards] = scanRow(R, dXCoord, length,
                                                        vertBoards,
                                                        xCoord, yCoord);
        boards += dBoards;
        if ~R.is_bord('n')
            [xCoord, yCoord] = trueStep(R, 'n', xCoord, yCoord);
        end
        dXCoord *= -1;
    end
    XCoord = xCoord;
    YCoord = yCoord;
    Boards = boards;
end

function [XCoord, YCoord, Boards, VertBoards] = scanRow (R, dXCoord, length,
                                                         vertBoards,
                                                         xCoord, yCoord)
    boards = 0;
    prev = R.is_bord('n');
    for i = [1:length]
        [xCoord, yCoord] = moveFromTo(R, xCoord, yCoord,
                                      xCoord+dXCoord, yCoord);
        if (prev == 1) && ~R.is_bord('n')
            boards++;
        end
        prev = R.is_bord('n');
        if vertBoards{xCoord+1} && ~R.is_bord('o')
            boards++;
        end
        vertBoards{xCoord+1} = R.is_bord('o');
    end
    XCoord = xCoord;
    YCoord = yCoord;
    Boards = boards;
    VertBoards = vertBoards;
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

function [XCoord, YCoord] = moveFromTo (R, xCoord, yCoord, xCoordNew, yCoordNew)
    while ~(xCoord == xCoordNew) || ~(yCoord == yCoordNew)
        if xCoord < xCoordNew
            if ~R.is_bord('o')
                [xCoord, yCoord] = trueStep(R, 'o', xCoord, yCoord);
            else
                [xCoord, yCoord] = getRoundWall(R, 'o', xCoord, yCoord);
            end
        elseif xCoord > xCoordNew
            if ~R.is_bord('w')
                [xCoord, yCoord] = trueStep(R, 'w', xCoord, yCoord);
            else
                [xCoord, yCoord] = getRoundWall(R, 'w', xCoord, yCoord);
            end
        end
        if yCoord < yCoordNew
            if ~R.is_bord('n')
                [xCoord, yCoord] = trueStep(R, 'n', xCoord, yCoord);
            else
                [xCoord, yCoord] = getRoundWall(R, 'n', xCoord, yCoord);
            end
        elseif yCoord > yCoordNew
            if ~R.is_bord('s')
                [xCoord, yCoord] = trueStep(R, 's', xCoord, yCoord);
            else
                [xCoord, yCoord] = getRoundWall(R, 's', xCoord, yCoord);
            end
        end
    end
    XCoord = xCoord;
    YCoord = yCoord;
end

function [XCoord, YCoord] = getRoundWall (R, wallDirection, xCoord, yCoord)
    if wallDirection == 'n'
        direction = 'o';
    elseif wallDirection == 'o'
        direction = 's';
    elseif wallDirection == 's'
        direction = 'w';
    else
        direction = 'n';
    end
    iterator = 1;
    while R.is_bord(wallDirection)
        for i = [1:iterator]
            [xCoord, yCoord] = trueStep(R, direction, xCoord, yCoord);
        end
        direction = changeDirection(direction);
        iterator++;
    end
    [xCoord, yCoord] = trueStep(R, wallDirection, xCoord, yCoord);
    XCoord = xCoord;
    YCoord = yCoord;
end

function Direction = changeDirection (direction)
    if direction == 'n'
        Direction = 's';
    elseif direction == 'o'
        Direction = 'w';
    elseif direction == 's'
        Direction = 'n';
    else
        Direction = 'o';
    end
end