function checkCells (R)
    move(R,'s',0)
    move(R,'w',0)  
    move(R,'o',1)
    R.mark()
    direction = 'w';
    while ~R.is_bord('n')
        R.step('n')
        move(R, direction, 1)    
        R.mark()
        direction = changeDirection(direction);
    end
end
    
function move(R, direction, marker)
    while ~R.is_bord(direction)
        if marker & ~R.is_mark()
            R.mark()
        end
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