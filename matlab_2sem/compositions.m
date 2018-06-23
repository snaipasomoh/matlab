function Result = compositions (n)
	Result = compSupp(n, n);
end

function Result = compSupp (n, k, arr = [])	#arr is empty when compSupp is called and then it cantains temporary composition
	if (n < 0)
		Result = {};
		return;
	end
	if (n == 0)								#means that arr already contains full composition
		Result = arr;
		return;
	end
	Result = {};
	if (k - 1 > 0)
		Result = cat(2, Result, compSupp(n, k - 1, arr));
	end
	if (n - k >= 0)							#means that next term can be k
		arr = [arr k];
		Result = cat(2, Result, compSupp(n - k, k, arr));
	end
end