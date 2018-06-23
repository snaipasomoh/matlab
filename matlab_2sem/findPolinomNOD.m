function Result = findPolinomNOD (a, b)
	if b == 0
		Result = a;
		return;
	elseif length(b) == 1
		Result = b;
		return;
	end
	[~, r] = divPolinom(a, b);
	Result = findPolinomNOD(b, r);
end