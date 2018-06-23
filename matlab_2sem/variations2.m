function Result = variations2 (alphabet, k)
	Result = [];
	n = length(alphabet);
	for i = [0:n ^ k - 1]
		Result = [Result; makeVariation(alphabet, i, n, k)];
	end
end

function Result = makeVariation (alphabet, m, n, k)
	Result = [];
	for i = [k-1:-1:0]
		Result = [Result, alphabet(floor(m / (n ^ i)) + 1)];
		m = mod(m, n ^ i);
	end
end