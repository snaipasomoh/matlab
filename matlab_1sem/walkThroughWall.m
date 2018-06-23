function walkThroughWall (R)
    length = 1;
    door = 0;
    direction = 'w';
    while R.is_bord('n')
        move(R, direction, length);
        direction = changeDirection(direction);
        length++;
    end
    R.step('n')
end

function move (R, direction, steps)
    for i = [1:steps]
        R.step(direction)
    end
end

function Direction = changeDirection (direction)
    if direction == 'o'
        Direction = 'w';
    else
        Direction = 'o';
    end
end