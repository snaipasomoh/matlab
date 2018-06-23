function findMarkerThroughWalls (R)
    XCOORD = 0;
    YCOORD = 0;
    marker = 0;
    iterator = 1;
    while ~marker
        [XCOORD, YCOORD, marker] = checkSegment(R, createPath(iterator),
                                                XCOORD, YCOORD);
        iterator++;
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
        
function Path = createPath (segmentNumber)
    up    = {0, 1};
    down  = {0, -1};
    right = {1, 0};
    left  = {-1, 0};
    path = {up};
    position = 2;
    for i = [1:segmentNumber]
        path{position} = left;
        position++;
    end
    for i = [1:segmentNumber*2]
        path{position} = down;
        position++;
    end
    for i = [1:segmentNumber*2]
        path{position} = right;
        position++;
    end
    for i = [1:segmentNumber*2]
        path{position} = up;
        position++;
    end
    for i = [1:segmentNumber]
        path{position} = left;
        position++;
    end
    Path = path;
end

function [XCoord, YCoord, Marker] = checkSegment (R, path, xCoord, yCoord)
    marker = 0;
    for i = path
        if ~marker
            dXCoord = i{1}{1}; 
            dYCoord = i{1}{2};
            [xCoord, yCoord] = moveFromTo(R, xCoord, yCoord,
                                          xCoord + dXCoord,
                                          yCoord + dYCoord);
             if R.is_mark()
                 marker = 1;
             end
        end
     end
     XCoord = xCoord;
     YCoord = yCoord;
     Marker = marker;
end