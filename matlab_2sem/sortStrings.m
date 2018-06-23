function Result = sortStrings (array)
	global tempArr = array;
	ptrs = [1:length(array(:, 1))];
	ptrs = quickSort(ptrs, @cStrCmp);
	Result = "";
	for i = ptrs
		Result = [Result; array(i, :)];
	end
end

function Result = cStrCmp (a, b)
	global tempArr;
	if (!length(tempArr(a, :)) && length(tempArr(b, :)))
		Result = 1;
		return;
	elseif (!length(tempArr(b, :)))
		Result = -1;
		return;
	end;
	i = 1;
	while (tempArr(a, i) == tempArr(b, i))
		i++;
		if (i > length(tempArr(a, :)) && i <= length(tempArr(b, :)))
			Result = 1;
			return;
		elseif (i <= length(tempArr(a, :)) && i > length(tempArr(b, :)))
			Result = -1;
			return;
		elseif (i > length(tempArr(a, :)) && i > length(tempArr(b, :)))
			Result = 0;
			return;
		end
	end
	if (tempArr(a, i) >= 'A' && tempArr(a, i) <= 'Z' &&
		tempArr(b, i) >= 'a' && tempArr(b, i) <= 'z' &&
		tempArr(a, i) - 'A' > tempArr(b, i) - 'a')
		Result = -1;
	elseif (tempArr(a, i) < tempArr(b, i))
		Result = 1;
	else
		Result = -1;
	end
end