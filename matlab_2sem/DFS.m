function Result = DFS (start, finish, adjMatrix)
	if (start == finish)
		Result = 0;
		return;
	end
	Result = inf;
	len = length(adjMatrix);
	t = -ones(1, len);
	adjMatrix(start, :) = t;
	for i = [1:len]
		t = adjMatrix(i, start);
		if (t >= 0)
			tRes = DFS(i, finish, adjMatrix);
			if (tRes >= 0)
				Result = min(Result, tRes + t);
			end
		end
	end
	if (Result == inf)
		Result = -1;
	end
end