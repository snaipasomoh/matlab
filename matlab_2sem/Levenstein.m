function Result = Levenstein (a, b)
	matrix = [0];
	for i = [1:length(a) + 1]
		for j = [1:length(b) + 1]
			if (i == 1)
				matrix(i, j) = j - 1;
			elseif (j == 1)
				matrix(i, j) = i - 1;
			else
				matrix(i, j) = min([matrix(i - 1, j) + 1,
									matrix(i, j - 1) + 1,
									(matrix(i - 1, j - 1) +
									!(a(i - 1) == b(j - 1)))]);
			end
		end
	end
	Result = matrix(end, end);
	editReq(matrix, a, b)
end

function Result = editReq (matrix, a, b)
	Result = "";
	[i, j] = size(matrix);
	while (i > 1 || j > 1)
		temp = "";
		if (i == 1)
			j--;
			temp = ["Insert ", b(j)];
		elseif (j == 1)
			i--;
			temp = ["Delete ", a(i)];
		elseif ((matrix(i, j-1) < matrix(i-1, j)) &&
				(matrix(i, j-1) < matrix(i-1, j-1)))
			j--;
			temp = ["Insert ", b(j)];
		elseif ((matrix(i-1, j) < matrix(i, j-1)) &&
				(matrix(i-1, j) < matrix(i-1, j-1)))
			i--;
			temp = ["Delete ", a(i)];
		elseif (matrix(i-1, j-1) != matrix(i, j))
			i--;
			j--;
			temp = ["Replace ", a(i), " with ", b(j)];
		else
			i--;
			j--;
		end
		if (length(temp))
			Result = [temp; Result];
		end
	end
end