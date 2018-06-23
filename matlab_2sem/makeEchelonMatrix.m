function [Result, free] = makeEchelonMatrix (matrix, epsilon = 0.0001)
	len = length(matrix(1, :));
	hei = length(matrix(:, 1));
	
	for i = [hei:len-1]
		matrix = [matrix; zeros(len)];
	end

	stage = 1;
	free = [];
	for i = [1:len-1]
		maxVal = matrix(stage, i);
		indOfMax = stage;
		for j = [stage:hei]
			if abs(matrix(j, i)) > maxVal;
				indOfMax = j;
				maxVal = abs(matrix(j, i));
			end
		end

		if maxVal < epsilon
			free = [free, [i]];
			continue;
		end

		tempRow = matrix(stage, :);
		matrix(stage, :) = matrix(indOfMax, :)*sign(matrix(indOfMax, i));
		matrix(indOfMax, :) = tempRow;

		for j = [1:hei]
			if j == stage
				continue;
			end
			matrix(j, :) -= matrix(stage, :)*matrix(j, i)/matrix(stage, i);
		end
		stage++;
	end

	for i = [1 : len]
		for j = [1 : hei]
			if (abs(matrix(j, i)) < epsilon)
				matrix(j, i) = 0;
			end
		end
	end
	Result = matrix;
end