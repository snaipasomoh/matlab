function Result = Hamming (a, b)
	if (length(a) != length(b))
		Result = NaN;
		return;
	end;
	Result = 0;
	for i = [1:length(a)]
		if (a(i) != b(i))
			Result++;
		end
	end
end