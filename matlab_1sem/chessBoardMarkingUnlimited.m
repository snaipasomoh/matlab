function chessBoardMarkingUnlimited (R)
    R.mark()
    flag = 1;
    iterator = 0;
    while iterator < 10
        R.step('n')
        flag = ~flag;
        if flag
            R.mark()
        end
        flag = markSegment(R, iterator+1, flag);
        iterator++;
    end
end

function Flag = markSegment (R, segmentNumber, flag)
    for direction = createPath(segmentNumber)
        R.step(direction)
        flag = ~flag;
        if flag
            R.mark()
        end
    end
    Flag = flag;
end

function Path = createPath (segmentNumber)
    Path = strjoin({multiplyText('w', segmentNumber),
                    multiplyText('s', segmentNumber*2),
                    multiplyText('o', segmentNumber*2),
                    multiplyText('n', segmentNumber*2),
                    multiplyText('w', segmentNumber)},
                    {'','','',''});
end

function Text = multiplyText (text, multiplier)
    t = text;
    for i = 1:multiplier-1
        t = strjoin({t, text},{''});
    end
    Text=t;
end