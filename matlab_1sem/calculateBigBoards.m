function calculateBigBoards (R)
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
    for i = [1:hight]
        [VERTBOARDS, HORBOARDS, XCOORD, YCOORD, boards] = scanRow(R, direction,
                                                                  length, 
                                                                  VERTBOARDS,
                                                                  HORBOARDS,
                                                                  XCOORD,
                                                                  YCOORD);
        BOARDS += boards;
        if ~R.is_bord('n')
            [XCOORD, YCOORD] = trueStep(R, 'n', XCOORD, YCOORD);
        end
        direction *= -1;
    end
    BOARDS
end

function [VertBoards, HorBoards, XCoord, YCoord, Boards] = scanRow (R, dXCoord,
                                                            length,
                                                            vertBoards,
                                                            horBoards,
                                                            xCoord, yCoord)
    boards = 0;
    for i = [1:length-1]
        if R.is_bord('w') && ~vertBoards(xCoord, yCoord)
            [vertBoards, horBoards] = rightInWall(R, 'w',
                                                  vertBoards, horBoards,
                                                  xCoord, yCoord);
            boards++;
        end
        if R.is_bord('s') && ~horBoards(xCoord, yCoord)
            [vertBoards, horBoards] = rightInWall(R, 's',
                                                  vertBoards, horBoards,
                                                  xCoord, yCoord);
            boards++;
        end
        [xCoord, yCoord] = stepFromTo (R, xCoord, yCoord,
                                       xCoord+dXCoord, yCoord);
    end
    VertBoards = vertBoards;
    HorBoards = horBoards;
    XCoord = xCoord;
    YCoord = yCoord;
    Boards = boards;
end

function [Length, Hight] = calibrate (R)
    xCoord = 0;
    yCoord = 0;
    vertFlag = 1;
    horFlag = 1;
    length = 1;
    hight = 1;
    while vertFlag || horFlag
        if horFlag
            if R.is_bord('o')
                [xCoord, yCoord, horFlag] = stepThrowWall(R, 'o', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 'o', xCoord, yCoord);
            end
        end
        if vertFlag
            if R.is_bord('n')
                [xCoord, yCoord, vertFlag] = stepThrowWall(R, 'n', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 'n', xCoord, yCoord);
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

function [XCoord, YCoord, Stepped] = stepThrowWall (R, direction, xCoord, yCoord)
    startX = xCoord;
    startY = yCoord;
    startD = direction;
    if direction == 'n'
        finX = xCoord;
        finY = yCoord+1;
    elseif direction == 'o'
        finX = xCoord+1;
        finY = yCoord;
    elseif direction == 's'
        finX = xCoord;
        finY = yCoord-1;
    else
        finX = xCoord-1;
        finY = yCoord;
    end
    stepped = 1;
    rightHand = direction;
    front = makeFront(rightHand);
    while R.is_bord(front)
        [front, rightHand] = turnLeft(front);
    end
    [xCoord, yCoord] = trueStep(R, front, xCoord, yCoord);
    while ~(xCoord == finX && yCoord == finY)
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
        if xCoord == startX && yCoord == startY && startD == rightHand
            stepped = 0;
            break;
        end
    end
    XCoord = xCoord;
    YCoord = yCoord;
    Stepped = stepped;
end

function [XCoord, YCoord] = stepFromTo (R, xCoord, yCoord, newXCoord, newYCoord)
    while ~(xCoord == newXCoord && yCoord == newYCoord)
        if xCoord < newXCoord
            if R.is_bord('o')
                [xCoord, yCoord, horFlag] = stepThrowWall(R, 'o', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 'o', xCoord, yCoord);
            end
        end
        if xCoord > newXCoord
            if R.is_bord('w')
                [xCoord, yCoord, horFlag] = stepThrowWall(R, 'w', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 'w', xCoord, yCoord);
            end
        end
        if yCoord < newYCoord
            if R.is_bord('n')
                [xCoord, yCoord, vertFlag] = stepThrowWall(R, 'n', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 'n', xCoord, yCoord);
            end
        end
        if yCoord > newYCoord
            if R.is_bord('s')
                [xCoord, yCoord, vertFlag] = stepThrowWall(R, 's', xCoord, yCoord);
            else
                [xCoord, yCoord] = trueStep(R, 's', xCoord, yCoord);
            end
        end
    end 
    XCoord = xCoord;
    YCoord = yCoord;
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