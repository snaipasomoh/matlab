function Result = eulerianCycle (adjMatrix)
	for i = length(adjMatrix)
		if (mod(length(find(adjMatrix(i, :) != -1)), 2))
			Result = -1;
			return;
		end
	end
	stack = [1];
	p = 1;
	cycle = [];
	while (p)
		adjMatrix
		currVert = stack(p);
		temp = find(adjMatrix(currVert, :) != -1);
		if (!length(temp))
			cycle = [cycle, currVert];
			p--;
		else
			i = temp(1);
			adjMatrix(currVert, i) = -1;
			adjMatrix(i, currVert) = -1;
			p++;
			stack(p) = i;
		end
	end
	adjMatrix
	Result = cycle;
	if (length(find(adjMatrix != -1)))
		Result = -1;
	end
end