function walkThroughLabyrinth (R)
    [front, rightHand] = calibrate (R);
    while ~R.is_mark()
        if R.is_bord(rightHand)
            if R.is_bord(front)
                [front, rightHand] = turnLeft(R, front);
            else
                R.step(front)
            end
        else
            [front, rightHand] = turnRight(R, front);
            R.step(front)
        end
    end
end

function [Front, RightHand] = calibrate (R)
    if ~R.is_bord('n')
        Front = 'n';
        RightHand = 'o';
    elseif ~R.is_bord('o')
        Front = 'o';
        RightHand = 's';
    elseif ~R.is_bord('s')
        Front = 's';
        RightHand = 'w';
    else
        Front = 'w';
        RightHand = 'n';
    end
end

function [Front, RightHand] = turnRight (R, front)
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

function [Front, RightHand] = turnLeft (R, front)
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