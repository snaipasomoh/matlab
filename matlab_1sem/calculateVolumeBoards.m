function calculateVolumeBoards (R)
    XCOORD = 1;
    YCOORD = 1;
    BOARDS = 0;
    boards = 0;
    [length, hight] = calibrate(R);
    VERTBOARDS = zeros(length, hight);
    HORBOARDS = zeros(length, hight);
    [VERTBOARDS, HORBOARDS] = rightInWall(R, 'w', VERTBOARDS, HORBOARDS,
                                          XCOORD, YCOORD);
    direction = 1;
    while ~(YCOORD == hight)
        [XCOORD, YCOORD] = trueStep(R, 'n', XCOORD, YCOORD);
        [XCOORD, YCOORD, VERTBOARDS, HORBOARDS boards] = scanRow(R, direction,
                                                                 VERTBOARDS,
                                                                 HORBOARDS,
                                                                 length,
                                                                 XCOORD,
                                                                 YCOORD);
        BOARDS += boards;
        direction = ~direction;
    end
    BOARDS
end

function [XCoord, YCoord, VertBoards, HorBoards, Boards] = scanRow (R,
                                                                    direction,
                                                                    vertBoards,
                                                                    horBoards,
                                                                    length,
                                                                    xCoord,
                                                                    yCoord);
    if direction
        direction = 'o';
        finX = length;
    else
        direction = 'w';
        finX = 1;
    end
    boards = 0;
    while ~(xCoord == finX)
        if R.is_bord('w') && ~vertBoards(xCoord, yCoord)
            [vertBoards, horBoards] = rightInWall(R, 'w', vertBoards, horBoards,
                                                  xCoord, yCoord);
            boards++;
        end
        if R.is_bord('s') && ~horBoards(xCoord, yCoord)
            [vertBoards, horBoards] = rightInWall(R, 's', vertBoards, horBoards,
                                                  xCoord, yCoord);
            boards++;
        end
        if R.is_bord(direction)
            [xCoord, yCoord, walked] = walkThroughBoard(R, direction,
                                                        xCoord, yCoord);
        else
            [xCoord, yCoord] = trueStep(R, direction, xCoord, yCoord);
        end
    end
    XCoord = xCoord;
    YCoord = yCoord;  
    VertBoards = vertBoards;
    HorBoards = horBoards;
    Boards = boards;
end

function [Length, Hight] = calibrate (R)
    xCoord = 0;
    yCoord = 0;
    walkedHor = 1;
    walkedVert = 1;
    length = 1;
    hight = 1;
    while walkedHor || walkedVert
        if walkedHor
            if R.is_bord('o')
                [xCoord, yCoord, walkedHor] = walkThroughBoard(R, 'o', 
                                                               xCoord, yCoord);
            else
                R.step('o')
            end
        end
        if walkedVert
            if R.is_bord('n')
                [xCoord, yCoord, walkedVert] = walkThroughBoard(R, 'n',
                                                                xCoord, yCoord);
            else
                R.step('n')
            end
        end
    end
    while ~R.is_bord('s')
        R.step('s')
        hight++;
    end
    while ~R.is_bord('w')
        R.step('w')
        length++;
    end
    Length = length;
    Hight = hight;
end

function [XCoord, YCoord, Walked] = walkThroughBoard (R, direction,
                                                      xCoord, yCoord)
    startX = xCoord;
    startY = yCoord;
    foundGood = 0;
    rightHand = direction;
    front = makeFront(rightHand);
    while R.is_bord(front)
        [front, rightHand] = turnLeft(front);
    end
    [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
    while ~(xCoord == startX && yCoord == startY && rightHand == direction)
        if R.is_bord(rightHand)
            if goodCell(direction, startX, startY, xCoord, yCoord)
                if foundGood
                    if ((abs(startX - goodX) + abs(startY - goodY)) >
                       (abs(startX - xCoord) + abs(startY - yCoord)))
                       goodX = xCoord;
                       goodY = yCoord;
                    end
                else
                    goodX = xCoord;
                    goodY = yCoord;
                end
                foundGood = 1;
            end
            if R.is_bord(front)
                [front, rightHand] = turnLeft(front);
            else 
                [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
            end
        else
            [front, rightHand] = turnRight(front);
            [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
        end
    end
    if foundGood
        while ~(xCoord == goodX && yCoord == goodY)
            if R.is_bord(rightHand)
                if R.is_bord(front)
                    [front, rightHand] = turnLeft(front);
                else 
                    [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
                end
            else
                [front, rightHand] = turnRight(front);
                [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
            end
        end
    end
    XCoord = xCoord;
    YCoord = yCoord;
    Walked = foundGood;
end

function Good = goodCell (direction, xCoord, yCoord, xCell, yCell)
    good = 0;
    if((direction == 'n' && xCoord == xCell && yCoord < yCell) ||
       (direction == 's' && xCoord == xCell && yCoord > yCell) ||
       (direction == 'o' && xCoord < xCell && yCoord == yCell) ||
       (direction == 'w' && xCoord > xCell && yCoord == yCell))
       good = 1;
    end
    Good = good;
end

function [VertBoards, HorBoards] = rightInCell (R, vertBoards, horBoards,
                                                direction, xCoord, yCoord)
    if direction == 's'
        horBoards(xCoord, yCoord) = 1;
    elseif direction == 'n'
        horBoards(xCoord, yCoord+1) = 1;
    elseif direction == 'w'
        vertBoards(xCoord, yCoord) = 1;
    else
        vertBoards(xCoord+1, yCoord) = 1;
    end
    VertBoards = vertBoards;
    HorBoards = horBoards;
end

function [VertBoards, HorBoards] = rightInWall (R, direction, vertBoards,
                                                horBoards, xCoord, yCoord)
    startX = xCoord;
    startY = yCoord;
    rightHand = direction;
    front = makeFront(rightHand);
    [vertBoards, horBoards] = rightInCell (R, vertBoards, horBoards,
                                           rightHand, xCoord, yCoord);
    while R.is_bord(front)
        [front, rightHand] = turnLeft(front);
        [vertBoards, horBoards] = rightInCell (R, vertBoards, horBoards,
                                               rightHand, xCoord, yCoord);
    end
    [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
    while ~(xCoord == startX && yCoord == startY && rightHand == direction)
        if R.is_bord(rightHand)
            [vertBoards, horBoards] = rightInCell (R, vertBoards, horBoards,
                                                   rightHand, xCoord, yCoord);
            if R.is_bord(front)
                [front, rightHand] = turnLeft(front);
            else 
                [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
            end
        else
            [front, rightHand] = turnRight(front);
            [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
        end
    end
    VertBoards = vertBoards;
    HorBoards = horBoards;
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

function [Front, RightHand] = turnRight (front)
    if front == 'n'
        Front = 'o';
        RightHand = 's';
    elseif front == 'o'
        Front = 's';
        RightHand = 'w';
    elseif front == 's'
        Front = 'w';
        RightHand = 'n';
    else
        Front = 'n';
        RightHand = 'o';
    end
end

function [Front, RightHand] = turnLeft (front)
    if front == 'n'
        Front = 'w';
        RightHand = 'n';
    elseif front == 'o'
        Front = 'n';
        RightHand = 'o';
    elseif front == 's'
        Front = 'o';
        RightHand = 's';
    else
        Front = 's';
        RightHand = 'w';
    end
end

function Front = makeFront (rightHand)
    if rightHand == 'n'
        Front = 'w';
    elseif rightHand == 'o'
        Front = 'n';
    elseif rightHand == 's'
        Front = 'o';
    else
        Front = 's';
    end
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