function Result = dijkstra (start, finish, adjMatrix)
	distances = inf * ones(1, length(adjMatrix));
	processedVerts = zeros(1, length(adjMatrix));
	distances(start) = 0;
	while (length(find(processedVerts == 0)))
		temp = processedVerts + 1;
		temp(find(temp == 2)) = inf;
		temp .*= distances;
		currVert = find(temp == min(temp))(1);
		processedVerts(currVert) = 1;
		for i = [1:length(adjMatrix)]
			if (adjMatrix(currVert, i) >= 0)
				t = adjMatrix(currVert, i) + distances(currVert);
				if (distances(i) > t)
					distances(i) = t;
				end
			end
		end
	end
	Result = distances(finish);
end