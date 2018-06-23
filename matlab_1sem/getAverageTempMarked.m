function getAverageTempMarked (R)
    [Steps, Values] = moveAndCheck(R, 's');
    [Steps, Values] = moveAndCheck(R, 'w'); 
    direction = 'o';
    [Steps, Values] = moveAndCheck(R, 'o');
    while ~R.is_bord('n')
        if R.is_mark
            Values += R.get_tmpr();
            Steps++;
        end
        R.step('n')
        [steps, values] = moveAndCheck(R, direction);    
        direction = changeDirection(direction);
        Steps += steps;
        Values += values;
    end
    Values/Steps
end
     
function [Steps, Values] = moveAndCheck (R, direction)
    steps = 0;
    values = 0;
    while ~R.is_bord(direction)
        if R.is_mark
            values += R.get_tmpr();
            steps++;
        end
        R.step(direction)
    end
    Steps = steps;
    Values = values;
end
    
function Direction = changeDirection (direction)
    if direction == 'o'
        Direction = 'w';
    else
        Direction = 'o';
    end
end