function Result = quickSort (Q, sortCond)
	right = length(Q);
	left = 1;
	if (left < right)
		mid = floor((left + right)/2);
		i = left;
		j = right;
		supp = Q(mid);
		while (i <= j)
			while (sortCond(Q(i), supp) == 1)
				i++;
			end
			while (sortCond(supp, Q(j)) == 1)
				j--;
			end
			if (i <= j)
				t = Q(i);
				Q(i) = Q(j);
				Q(j) = t;
				i++;
				j--;
			end
		end
		Result = [quickSort(Q(1:i-1), sortCond) quickSort(Q(i:right), sortCond)];
	else
		Result = [Q];
	end
end