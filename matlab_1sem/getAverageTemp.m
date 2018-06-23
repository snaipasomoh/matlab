function getAverageTemp (R)
    move(R, 's')
    move(R, 'w')
    valueSum = 0;
    stepSum = 0;
    direction = 'w';
    [step, value] = moveAndRead(R, 'o');
    valueSum += value;
    stepSum += step;
    while ~R.is_bord('n')
        valueSum += readAndStep(R,'n');
        stepSum++;
        [stepSum, valueSum] = moveAndRead(R, direction);
        valueSum += value;
        stepSum += step;
        direction = changeDirection(direction);
    end
    valueSum += R.get_tmpr();
    stepSum++;
    valueSum/stepSum
end

function Value = readAndStep (R, direction)
    Value = R.get_tmpr();
    R.step(direction)
end

function [Steps, Values] = moveAndRead (R, direction)
    values=0;
    steps=0;
    while ~R.is_bord(direction)
        values += readAndStep(R, direction);
        steps++;
    end
    Steps = steps;
    Values = values;
end

function move (R, direction)
    while ~R.is_bord(direction)
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