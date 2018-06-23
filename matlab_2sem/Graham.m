function Result = Graham (Q)
	figure;
	hold on;
	axis equal;
	Q = grSort(Q);
	stack = [Q(1, :); Q(2, :)];
	len = 2;
	Q
	for i = [3:size(Q)(1)]
		while (nonLeftAngle(stack(len, :), stack(len-1, :), Q(i, :)))
			stack = stack(1:len-1, :);
			len--;
		end
		stack = [stack; Q(i, :)];
		len++;
	end
	for i = [1:len]
		plot(stack(i, 1), stack(i, 2), '.', 'color', 'r');
	end
	Result = stack;
end

function Result = grSort (Q)
	for i = [1:size(Q)]
		plot(Q(i, 1),Q(i, 2), '.');
		if (Q(i, 1) < Q(1, 1) || (Q(i, 1) == Q(1, 1) &&
								  Q(i, 2) < Q(1, 2)))
			t = Q(i, :);
			Q(i, :) = Q(1, :);
			Q(1, :) = t;
		end
	end
	zeroPoint = Q(1, :);
	Result = [zeroPoint; quickSort(Q(2:size(Q), :), zeroPoint)];
end

function Result = nonLeftAngle (A, B, C)
	x1 = B(1) - A(1);
	y1 = B(2) - A(2);
	x2 = C(1) - A(1);
	y2 = C(1) - A(2);
	t = x1*y2 - x2*y1;
	
	if (t < 0)
		Result = 0;
	else
		Result = 1;
	end;
end

function Result = smaller (A, B, zeroPoint)
	#x1*y2-x2*y1 < 0
	x1 = A(1) - zeroPoint(1);
	x2 = B(1) - zeroPoint(1);
	y1 = A(2) - zeroPoint(2);
	y2 = B(2) - zeroPoint(2);
	t = x1*y2 - x2*y1;
	if (t == 0)
		if(pow2(x1) + pow2(y1) < pow2(x2) + pow2(y2))
			Result = 1;
		else
			Result = 0;
		end
	elseif (t > 0)
		Result = 1;
	else
		Result = 0;
	end
end

function Result = quickSort (Q, ZeroPoint)
	right = size(Q)(1);
	left = 1;
	if (left < right)
		mid = floor((left + right)/2);
		i = left;
		j = right;
		while (i < j)
			while (smaller(Q(i, :), Q(mid, :), ZeroPoint))
				i++;
			end
			while (smaller(Q(mid, :), Q(j, :), ZeroPoint))
				j--;
			end
			if (i <= j)
				t = Q(i, :);
				Q(i, :) = Q(j, :);
				Q(j, :) = t;
				i++;
				j--;
			end
		end
		Result = [quickSort(Q(1:i-1, :), ZeroPoint); quickSort(Q(i:right, :), ZeroPoint)];
	else
		Result = [Q];
	end
end