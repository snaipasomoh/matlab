function a = nn24 (n)
    for i = [1:n]
        for j = [1:n]
            if i == 1 || j == 1
                a(i,j) = 1;
            elseif i>n+1-j || j>n+1-i
                a(i,j) = 0;
            else
                a(i,j) = a(i-1,j)+a(i,j-1);
            end
        end
    end
end