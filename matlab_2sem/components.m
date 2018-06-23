function Result = components (adjMatrix)
	processedVerts = zeros(1, length(adjMatrix));
	Result = 0;
	for i = [1:length(adjMatrix)]
		if (!processedVerts(i))
			Result++;
			Queue = [i];
			head = 1;
			while (head <= length(Queue))
				currVert = Queue(head);
				head++;
				if (processedVerts(currVert))
					continue;
				end
				processedVerts(currVert) = 1;
				for j = [1:length(adjMatrix)]
					if (adjMatrix(currVert, j) >= 0)
						Queue(end + 1) = j;
					end
				end
			end
		end
	end
end