function Result = prim (adjMatrix)
	Result = "";
	processedVerts = zeros(1, length(adjMatrix));
	processedVerts(1) = 1;
	while (length(find(processedVerts == 0)))
		tLen = inf;
		for i = find(processedVerts == 1)
			for j = [1:length(adjMatrix)]
				if (processedVerts(j) == 0)
					t = adjMatrix(i, j);
					if (t >= 0 && t < tLen)
						tLen = t;
						s = i;
						f = j;
					end
				end
			end
		end
		if (tLen == inf)
			"Several components"
			return;
		end
		processedVerts(f) = 1;
		Result = [Result, cat(2, "(", num2str(s), ", ", num2str(f), ")")];
	end
end