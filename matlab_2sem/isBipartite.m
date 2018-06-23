function Result = isBipartite (adjMatrix)
	distances = -ones(1, length(adjMatrix));
	processedVerts = zeros(1, length(adjMatrix));
	Queue = [1];
	head = 1;
	distances(1) = 0;
	while (head <= length(Queue))
		currVert = Queue(head);
		head++;
		if (processedVerts(currVert))
			continue;
		end
		processedVerts(currVert) = 1;
		for i = [1:length(adjMatrix)]
			if (adjMatrix(currVert, i) >= 0)
				Queue(end + 1) = i;
				t = mod(distances(currVert) + 1, 2);
				if (distances(i) < 0)
					distances(i) = t;
				elseif (distances(i) != t)
					Result = 0;
					return;
				end
			end
		end
	end
	Result = 1;
end