function Result = floydWarshall (start, finish, adjMatrix) #if start == finish than we must go out of start and then return int itback
		adjMatrix(find(adjMatrix == -1)) = inf;
	len = length(adjMatrix);
	for k = [1:len]
		adjMatrix
		for i = [1:len]
			for j = [1:len]
				adjMatrix(i, j) = min(adjMatrix(i, j),
									  adjMatrix(i, k) + adjMatrix(k, j));
			end
		end
	end
	adjMatrix
	Result = adjMatrix(start, finish);
end