function Result = variations (alphabet, len)
	var = ones(1, len) * alphabet(1);
	tRes = ones(1, len) * alphabet(end);
	Result = var;
	while (!isequal(var, tRes))
		var = nextVariation(alphabet, var);
		Result = [Result; var];
	end
end

function Result = nextVariation (alphabet, var)
	for i = [length(var):-1:1]
		if (var(i) == alphabet(end))
			var(i) = alphabet(1);
		else
			var(i) = alphabet(find(alphabet == var(i)) + 1);
			break;
		end
	end
	Result = var;
end