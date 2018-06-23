function [Result, Solution] = makeGaussBackSteps (matrix, free)
	len = length(matrix(1, :));
	hei = length(matrix(:, 1));

	if ~length(free)
		Solution = [];
		for i = [1:hei]
			if i == len
				break;
			end
			Solution = [Solution; [matrix(i, len)/matrix(i, i)]];
			Result = "SS";
		end
	else
		Result = [];
		for i = free
			Solution = zeros(len-1, 1);
			Solution(i) = 1;
			for j = [hei:-1:1]
				for k = [1:len-1]
					if matrix(j, k)
						tempSum = 0;
						for t = [k+1:len-1]
							tempSum -= matrix(j, t)*Solution(t);
						end
						Solution(k) = tempSum/matrix(j, k);
						break;
					end
				end
			end
			Result = [Result, Solution];
			
			Solution = zeros(len-1, 1);
			for j = [hei:-1:1]
				for k = [1:len-1]
					if matrix(j, k)
						tempSum = matrix(j, len);
						for t = [k+1:len-1]
							tempSum -= matrix(j, t)*Solution(t);
						end
						Solution(k) = tempSum/matrix(j, k);
						break;
					end
				end
			end
		end
	end
end