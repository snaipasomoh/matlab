function Result = permutations (alphabet)
	var = alphabet;
	Result = [var];
	for i = [1:factorial(length(alphabet)) - 1]
		j = length(alphabet) - 1;
		while (find(alphabet == var(j)) > find(alphabet == var(j+1)))
			j--;
		end
		k = length(alphabet);
		while (find(alphabet == var(k)) < find(alphabet == var(j)))
			k--;
		end
		t = var(j);
		var(j) = var(k);
		var(k) = t;
		var(j+1:end) = var(end:-1:j+1);
		Result = [Result; var];
	end
end