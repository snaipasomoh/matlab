function [Result, Solution] = solveSLE (A, B, epsilon = 0.0001)
	if rank(A) ~= rank([A, B])
		Solution = zeros(length(B), 1);
		Result = "NS";
	else
		[echelMat, freeVars] = makeEchelonMatrix([A, B], epsilon);
		[Result, Solution] = makeGaussBackSteps(echelMat, freeVars);
	end
end