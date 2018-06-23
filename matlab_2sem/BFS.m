function Result = BFS (start, finish, adjMatrix)	#returns distance from start to finish or -1
	distances = -ones(1, length(adjMatrix));
	processedVerts = zeros(1, length(adjMatrix));
	Queue = [start];
	head = 1;
	distances(start) = 0;
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
				t = adjMatrix(currVert, i) + distances(currVert);
				if !(distances(i) >= 0 && distances(i) <= t)
					distances(i) = t;
				end
			end
		end
		if (currVert == finish)
			Result = distances(currVert);
			return;
		end
	end
	Result = -1;
end