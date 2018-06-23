function findMarker (R)
    marker = 0;
    iterator = 1;
    while ~marker
        for direction = createPath(iterator)
            if R.is_mark()
                marker = 1;
            end
            if ~marker
                R.step(direction)
            end
        end
        iterator++;
    end
end           

function Path = createPath (segmentNumber)
    Path = strjoin({'n',
                    multiplyText('w', segmentNumber),
                    multiplyText('s', segmentNumber*2),
                    multiplyText('o', segmentNumber*2),
                    multiplyText('n', segmentNumber*2),
                    multiplyText('w', segmentNumber)},
                    {'','','','',''});
end

function Text = multiplyText (text, multiplier)
    t = text;
    for i = 1:multiplier-1
        t = strjoin({t, text},{''});
    end
    Text=t;
end